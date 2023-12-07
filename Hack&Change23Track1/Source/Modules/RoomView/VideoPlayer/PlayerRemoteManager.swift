//
//  PlayerRemoteManager.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 05.12.2023.
//

import Foundation

protocol PlayerRemoteProvider: AnyObject {
    
    @MainActor
    func onChangePlayerState(_ state: RoomPlayerState)
}

@MainActor
class PlayerRemoteManager: ObservableObject, PlayerRemoteProvider {
    
    @Published private(set) var playList = [SourceAttrs]()
    @Published private(set) var currentVideo: VideoItem?
    @Published private(set) var playerEvent: PlayerEvent = .pause(0)
    @Published private(set) var showSetVideoLoader: Bool = false
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
    
    func addVideoItemInPlaylist(_ sourceId: String) {
        guard let id = room.id else { return }
        Task {
            showSetVideoLoader = true
            do {
                let newPlaylist = try await
                roomDataService.addVideoToPlaylist(roomId: id, sourceId: sourceId)
                self.playList = newPlaylist
                guard let last = playList.last else { return }
                setSource(last.id)
            } catch {
                appAlert = .errors(errors: [error])
                showSetVideoLoader = false
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
                appAlert = .errors(errors: [error])
            }
        }
    }
    
    func setSource(_ id: String?) {
        guard let uid = room.id,
              room.userIsOwner(for: currentUser.id),
              let id else { return }
        Task {
            showSetVideoLoader = true
            do {
                try await roomDataService.loadVideo(for: uid, sourceId: id)
            } catch {
                appAlert = .errors(errors: [error])
            }
            showSetVideoLoader = false
        }
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
        if currentVideo?.id != state.source?.id {
            let newVideo = VideoItem(id: source.id, url: url, name: source.name, cover: source.cover)
            self.currentVideo = newVideo
            playerEvent = .set(newVideo, state.currentSeconds)
        }
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
                    print("backward")
                    setPreviewsVideo()
                case .forward:
                    print("forward")
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
        setSource(playList[index + 1].id)
    }

    func setPreviewsVideo() {
        guard let index = playList.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != playList.first?.id else { return }
        setSource(playList[index - 1].id)
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
    
    private func setPlayerAction(_ action: RoomAction, arg: String = "") async throws {
        guard let id = room.id else { return }
        try await roomDataService.setRoomAction(for: id, action: action, arg: arg)
    }
        
    private func setCurrentVideo(_ id: String?, path: String?) {
        guard let id, let path,
              let first = playList.first(where: {$0.id == id}),
              let url = URL(string: path) else { return }
        currentVideo = .init(id: id, url: url, name: first.name, cover: first.cover)
    }
}
