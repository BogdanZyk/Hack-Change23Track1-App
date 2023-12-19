//
//  PlayerRemoteManager.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 05.12.2023.
//

import Foundation
import SchemaAPI

protocol PlayerRemoteProvider: AnyObject {
    
    @MainActor
    func onChangePlayerState(_ state: RoomPlayerState)
}

@MainActor
class PlayerRemoteManager: ObservableObject, PlayerRemoteProvider {
    
    @Published var playList = [PlaylistRowAttrs]()
    @Published private(set) var currentVideo: VideoItem?
    @Published private(set) var playerEvent: PlayerEvent = .pause(0)
    @Published private(set) var itemLoader: ItemStateLoading = .empty
    @Published var appAlert: AppAlert?
    
    private let room: RoomAttrs
    private let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    
    init(room: RoomAttrs,
         currentUser: RoomMember) {
        self.room = room
        self.currentUser = currentUser
        fetchPlaylist()
    }
    
    func addNewVideoItemAndSetToPlay(_ sourceId: String) {
        guard let id = room.id else { return }
        Task {
            itemLoader = .addingPlaylist
            do {
                let newPlaylist = try await
                roomDataService.addVideoToPlaylist(roomId: id, url: sourceId)
                
                self.playList = newPlaylist
                itemLoader = .empty
                if playList.count == 1 {
                    guard let last = playList.last else { return }
                    playerEvent = .play(0)
                    selectPlaylistItem(last.id)
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    func fetchPlaylist() {
        guard let id = room.id else { return }
        Task {
            do {
                let newPlaylist = try await roomDataService.getRoomPlaylist(for: id)
                self.playList = newPlaylist
            } catch {
                handleError(error)
            }
        }
    }
    
    func selectPlaylistItem(_ id: String?) {
        guard let roomId = room.id,
              room.userIsOwner(for: currentUser.id),
              let id else { return }
        Task {
            itemLoader = .setSource
            do {
                try await roomDataService.setRoomAction(for: roomId, action: .move, arg: id)
                itemLoader = .empty
            } catch {
                handleError(error)
            }
        }
    }
    
    func movePlaylistItem(for id: String, to index: Int) {
        guard let roomId = room.id else { return }
        Task {
            do {
                try await roomDataService.movePlaylistItem(roomId: roomId, playlistRowId: id, index: index)
            } catch {
                handleError(error)
            }
        }
    }
    
    func removeSource(for id: String) {
        guard let roomId = room.id else { return }
        Task {
            do {
                try await roomDataService.removePlaylistItem(roomId: roomId, playlistRowId: id)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        appAlert = .errors(errors: [error])
        itemLoader = .empty
    }
        
    func onChangePlayerState(_ state: RoomPlayerState) {
        print("changePlayerState", state.status, state.currentSeconds)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let seconds = state.currentSeconds
            switch state.status {
            case .play:
                self.playerEvent = .play(seconds)
            case .pause:
                self.playerEvent = .pause(seconds)
            case .move:
                self.playerEvent = .seek(seconds)
            case .changeSource:
                setNewVideoIfNeeded(state)
            }
        }
    }
    
    private func setNewVideoIfNeeded(_ state: RoomPlayerState) {
        guard let source = state.source,
              let url = state.wrappedUrl else { return }
        if currentVideo == nil {
            setVideoItem(source: source,
                         seconds: state.currentSeconds,
                         url: url,
                         withPlay: playerEvent.isPlay)
        } else if currentVideo?.id != state.source?.id {
            setVideoItem(source: source,
                         seconds: state.currentSeconds,
                         url: url,
                         withPlay: true)
        }
    }
    
    private func setVideoItem(source: RoomPlayerState.Source,
                          seconds: Double,
                          url: URL,
                          withPlay: Bool) {
        let newVideo = VideoItem(id: source.id, url: url, name: source.name, cover: source.cover)
        currentVideo = newVideo
        playerEvent = .set(newVideo, seconds, withPlay)
    }
    
    func handlePlayerEvents(_ event: PlayerEvent) {
        Task {
            do {
                switch event {
                case .play(let seconds):
                    try await setPlayerAction(.play, arg: "\(seconds)")
                case .pause(let seconds):
                    try await setPlayerAction(.pause, arg: "\(seconds)")
                case .seek(let seconds):
                    try await setPlayerAction(.move, arg: "\(seconds)")
                case .backward:
                    setPreviewsVideo()
                case .forward:
                    setNextVideo()
                case .set, .close:
                    break
                }
            } catch {
                appAlert = .errors(errors: [error])
            }
        }
    }
    
    func setNextVideo() {
        guard let index = playList.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != playList.last?.id else { return }
        selectPlaylistItem(playList[index + 1].id)
    }

    func setPreviewsVideo() {
        guard let index = playList.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != playList.first?.id else { return }
        selectPlaylistItem(playList[index - 1].id)
    }
    
    var isDisableControls: Bool {
        !room.userIsOwner(for: currentUser.id)
    }

    var isDisabledNext: Bool {
        playList.last?.id == currentVideo?.id
    }

    var isDisabledPreviews: Bool {
        playList.first?.id == currentVideo?.id
    }
    
    func closePlayer() {
        playerEvent = .close
    }
    
    private func setPlayerAction(_ action: MediaAction, arg: String = "") async throws {
        guard let id = room.id else { return }
        try await roomDataService.setRoomAction(for: id, action: action, arg: arg)
    }
        
    private func setCurrentVideo(_ id: String?, path: String?) {
        guard let id, let path,
              let source = playList.first(where: {$0.id == id})?.source,
              let url = URL(string: path) else { return }
        currentVideo = .init(id: id, url: url, name: source.name, cover: source.cover)
    }
    
    enum ItemStateLoading: Int {
        case addingPlaylist, setSource, empty
    }
}
