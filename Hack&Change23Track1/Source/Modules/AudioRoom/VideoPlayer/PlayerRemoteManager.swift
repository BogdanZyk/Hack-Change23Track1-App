//
//  PlayerRemoteManager.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 05.12.2023.
//

import Foundation

protocol PlayerRemoteProvider: AnyObject {
    
    func onChangePlayerState(_ state: RoomPlayerState)
    
    //    func updatePlaylistStatus(_ status: PlaylistStatus) {
    //        DispatchQueue.main.async { [weak self] in
    //            guard let self = self else {return}
    //            status.statuses.forEach { item in
    //                guard let index = self.playList.firstIndex(where: {$0.id == item.id}) else {return}
    //                self.playList[index].setStatus(item.status)
    //            }
    //        }
    //    }
}

class PlayerRemoteManager: ObservableObject, PlayerRemoteProvider {
    
    @Published private(set) var playList = [SourceAttrs]()
    @Published private(set) var currentVideo: VideoItem?
    @Published private(set) var playerEvent: PlayerEvent = .pause
    @Published var appAlert: AppAlert?
    
    private var room: RoomAttrs
    private let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    
    init(room: RoomAttrs,
         currentUser: RoomMember) {
        self.room = room
        self.currentUser = currentUser
        setTracks()
        setCurrentVideo(room.mediaInfo?.source?.id, path: room.mediaInfo?.url)
    }
    
    func refreshRoom() {
        guard let code = room.key else { return }
        Task {
            let room = try await roomDataService.findRoom(code)
            self.room = room
            self.setTracks()
        }
    }
    
    func addPlaylist(_ videos: [SourceAttrs], client: WebRTCClient?) {
        guard let client else { return }
        do {
            let remotePlayList = Playlist(files: videos.compactMap({$0.id}))
            let data = try JSONHelper.encoder.encode(remotePlayList)
            client.sendData(data)
            self.playList = videos
        } catch {
            appAlert = .errors(errors: [error])
        }
    }
    
    func setVideo(_ video: SourceAttrs) {
        guard let uid = room.id,
              room.userIsOwner(for: currentUser.id),
              let sourceId = video.id else { return }
        Task {
            do {
                try await roomDataService.loadVideo(for: uid, sourceId: sourceId)
            } catch {
                appAlert = .errors(errors: [error])
            }
        }
    }
        
    func onChangePlayerState(_ state: RoomPlayerState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            print(state.status, state.currentSeconds)
            let seconds = state.currentSeconds
            switch state.status {
            case .play:
                self.playerEvent = .play
            case .pause:
                self.playerEvent = .pause
            case .move:
                self.playerEvent = .seek(seconds)
            case .changeSource:
                break
                //                if currentVideo?.id != "remoteId" {
                //self.playerEvent = .set(.init(id: UUID().uuidString, url: state.wrappedUrl!), seconds)
                //                }
            }
        }
    }
    
    func handlePlayerEvents(_ event: PlayerEvent) {
        
        Task {
            do {
                switch event {
                case .play:
                    try await setPlayerAction(.play)
                case .pause:
                    try await setPlayerAction(.pause)
                case .seek(let double):
                    try await setPlayerAction(.move, arg: "\(double)")
                case .backward:
                    print("backward")
                    setPreviewsVideo()
                case .forward:
                    print("forward")
                    setNextVideo()
                case .end:
                    print("end")
                case .set:
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
        setVideo(playList[index + 1])
    }

    func setPreviewsVideo() {
        guard let index = playList.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != playList.first?.id else { return }
        setVideo(playList[index - 1])
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
    
    private func setPlayerAction(_ action: RoomAction, arg: String = "") async throws {
        guard let id = room.id else { return }
        try await roomDataService.setRoomAction(for: id, action: action, arg: arg)
    }
    
    private func setTracks() {
        guard let files = room.playlist?.compactMap({$0?.fragments.sourceAttrs}) else { return }
        playList = files
    }
    
    private func setCurrentVideo(_ id: String?, path: String?) {
        guard let id, let path,
              let first = playList.first(where: {$0.id == id}),
              let url = URL(string: path) else { return }
        currentVideo = .init(id: id, url: url, name: first.name, cover: first.cover)
    }
}
