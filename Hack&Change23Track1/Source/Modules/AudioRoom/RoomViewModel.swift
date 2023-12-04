//
//  RoomViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import WebRTC
import Combine

@MainActor
final class RoomViewModel: ObservableObject {
    
    @Published var appAlert: AppAlert?
    @Published private(set) var playerEvent: PlayerEvent = .play(0)
    @Published private(set) var room: RoomAttrs
    @Published private(set) var roomCountLikes: Int = 0
    @Published private(set) var members: [String: RoomMember] = [:]
    @Published private(set) var playList = [VideoItem]()
    @Published private(set) var currentVideo: VideoItem?
    @Published private(set) var status: WebRTCStatus = .new
    
    private(set) var receivedMessage = PassthroughSubject<Message, Never>()

    let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    private var webRTCClient: WebRTCClient?

    init(room: RoomAttrs,
         currentUser: RoomMember) {
        self.room = room
        self.roomCountLikes = room.likes ?? 0
        self.currentUser = currentUser
        self.setMembers()
        self.setTracks()
        self.setCurrentVideo(room.mediaInfo?.source?.id, url: room.mediaInfo?.url)
    }

    func connectRoom() async {
        prepareWebRTCClient()
        await sentOfferToServerAndSetRemoteSdp()
    }

    private func prepareWebRTCClient(){
        webRTCClient = WebRTCClient()
        self.webRTCClient?.delegate = self
    }

    func disconnectAll() {
        webRTCClient?.disconnect()
        RemoteCommandHelper.shared.removeNowPlayingItem()
    }

}

// MARK: - WebRTC logic
extension RoomViewModel {

    func sendMessageToDataChannel(_ message: Message) {
        guard let webRTCClient else { return }
        do {
            let data = try JSONHelper.encoder.encode(message)
            webRTCClient.sendData(data)
        } catch {
            appAlert = .errors(errors: [error])
        }
    }

    private func sendPlaylistToDataChannel(_ playlist: Playlist) {
        guard let webRTCClient else { return }
        do {
            let data = try JSONHelper.encoder.encode(playlist)
            webRTCClient.sendData(data)
        } catch {
            appAlert = .errors(errors: [error])
        }
    }

    private func sentOfferToServerAndSetRemoteSdp() async {
        guard let webRTCClient else { return }
        do {
            let sdpOffer = try await webRTCClient.offer()
            let sdpAnswer = try await initConnectionWithServer(.init(from: sdpOffer))
            try await webRTCClient.set(remoteSdp: sdpAnswer)
        } catch {
            appAlert = .errors(errors: [error])
        }

    }

    private func initConnectionWithServer(_ offer: SessionDescription) async throws -> RTCSessionDescription {
        try await roomDataService.initConnection(for: room.id ?? "", offer: offer).rtcSessionDescription
    }
}

// MARK: - Audio actions
extension RoomViewModel {

    func setVideo(_ video: VideoItem) {
        guard let id = room.id,
              room.userIsOwner(for: currentUser.id) else { return }
        Task {
            do {
                let newRoom = try await roomDataService.loadVideo(for: id, sourceId: video.id)
                setCurrentVideo(newRoom.mediaInfo?.source?.id, url: newRoom.mediaInfo?.url)
                try await setAudioAction(.play)
            } catch {
                appAlert = .errors(errors: [error])
            }
        }
    }

    func handlePlayerEvents(_ event: PlayerEvent) {
        
        Task {
            do {
                switch event {
                case .play(let double):
                    try await setAudioAction(.play, arg: "\(double)")
                case .pause(let double):
                    try await setAudioAction(.pause, arg: "\(double)")
                case .seek(let double):
                    try await setAudioAction(.move, arg: "\(double)")
                case .backward:
                    setPreviewsVideo()
                    print("backward")
                case .forward:
                    print("forward")
                    setNextvideo()
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

    func addPlaylist(_ videos: [VideoItem]) {
        self.playList = videos
        sendPlaylistToDataChannel(.init(files: videos.compactMap({$0.id})))
    }

    func updatePlaylistStatus(_ status: PlaylistStatus) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            status.statuses.forEach { item in
                guard let index = self.playList.firstIndex(where: {$0.id == item.id}) else {return}
                self.playList[index].setStatus(item.status)
            }
        }
    }

    func setNextvideo() {
        guard let index = playList.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != playList.last?.id else { return }
        setVideo(playList[index + 1])
    }

    func setPreviewsVideo() {
        guard let index = playList.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != playList.first?.id else { return }
        setVideo(playList[index - 1])
    }

    var isDisabledNext: Bool {
        playList.last?.id == currentVideo?.id
    }

    var isDisabledPreviews: Bool {
        playList.first?.id == currentVideo?.id
    }

    private func setAudioAction(_ action: RoomAction, arg: String = "") async throws {
        guard let id = room.id else { return }
        try await roomDataService.setRoomAction(for: id, action: action, arg: arg)
    }
}

extension RoomViewModel {

    var isOwner: Bool {
        room.userIsOwner(for: currentUser.id)
    }

    func likeRoom() {
        guard let id = room.id else { return }
        Task {
            try? await roomDataService.likeRoom(for: id)
        }
    }

    func refreshRoom() {
        guard let code = room.key else { return }
        Task {
            let room = try await roomDataService.findRoom(code)
            self.room = room
            self.setTracks()
        }
    }

    func updateRoom(_ template: RoomTemplate) {
        guard let id = room.id else {return}
        Task {
            do {
                let image = template.createBase64Image()
                try await roomDataService.updateRoom(for: id, name: template.name, image: image, isPrivate: template.isPrivateRoom)
                refreshRoom()
            } catch {
                self.appAlert = .errors(errors: [error])
            }
        }
    }

    private func setMembers() {
        guard let members = room.members else { return }
        members.forEach {
            guard let id = $0?.id, let user = $0?.fragments.userAttrs else { return }
            self.members[id] = RoomMember(user: user)
        }
    }

    private func setTracks() {
        guard let files = room.playlist?.compactMap({$0?.fragments.sourceAttrs}) else { return }
        playList = files.compactMap({.init(file: $0, status: .ok)})
    }
    
    private func setCurrentVideo(_ id: String?, url: String?) {
        guard let id, let index = playList.firstIndex(where: {$0.id == id}) else { return }
        playList[index].setUrl(url)
        currentVideo = playList[index]
    }
}


extension RoomViewModel: WebRTCClientDelegate {
    
    func webRTCClient(_ client: WebRTCClient, didStartReceivingOnTrack track: RTCVideoTrack) {}
    

    func webRTCClient(_ client: WebRTCClient, didAdd stream: RTCMediaStream) {}
    

    func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState) {
        print("Connection status ->", state.statusValue.rawValue)
        DispatchQueue.main.async {
            self.status = state.statusValue
        }
    }

    func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data) {
        print(String(data: data, encoding: .utf8))
        if let audioState = try? JSONHelper.decoder.decode(RoomPlayerState.self, from: data) {
            self.onChangeAudio(audioState)
        } else if let message = try? JSONHelper.decoder.decode(Message.self, from: data) {
            self.onReceivedMessage(message)
        } else if let playListState = try? JSONHelper.decoder.decode(PlaylistStatus.self, from: data) {
            self.updatePlaylistStatus(playListState)
        }
    }

    func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate) {}

    private func onReceivedMessage(_ message: Message) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            receivedMessage.send(message)

            if message.type == .joined {
                members[message.from.id] = message.from
            } else if message.type == .leaving {
                members.removeValue(forKey: message.from.id)
            }
        }
    }

    private func onChangeAudio(_ state: RoomPlayerState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
//
//            if roomCountLikes != state.likes {
//                roomCountLikes = state.likes
//            }
//
//            if state.fileId != audioState.id {
//                audioState = .init(from: state)
//                guard let currentVideo = videos.first(where: {$0.id == state.fileId}) else { return }
//                self.currentVideo = currentVideo
////                RemoteCommandHelper.shared.setupNowPlaying(RemoteCommandHelper.MediaItem(title: currentAudio.name ?? "No name", album: "Album", image: UIImage(systemName: "person")))
//
//            } else {
//                if !audioState.isPlay && state.status == .pause { return }
//                audioState.isPlay = state.status == .play
//                if !audioState.isScrubbingTime {
//                    audioState.time = state.current
//                }
//            }
        }
    }
}

