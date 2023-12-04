//
//  RoomViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import WebRTC
import Combine

//@MainActor
//final class RoomViewModel: ObservableObject {
//
//    @Published var refreshRemoteVideoTrack: Bool = false
//    @Published var audioState = AudioUIState()
//    @Published var appAlert: AppAlert?
//    @Published private(set) var room: RoomAttrs
//    @Published private(set) var roomCountLikes: Int = 0
//    @Published private(set) var members: [String: RoomMember] = [:]
//    @Published private(set) var audios = [AudioItem]()
//    @Published private(set) var currentAudio: AudioItem?
//    @Published private(set) var status: WebRTCStatus = .new
//    @Published private(set) var isMute: Bool = false
//
//    private(set) var remoteVideoTrack: RTCVideoTrack? {
//        didSet {
//            refreshRemoteVideoTrack = true
//        }
//    }
//
//    private(set) var receivedMessage = PassthroughSubject<Message, Never>()
//
//    let currentUser: RoomMember
//    private let roomDataService = RoomDataService()
//    private let webRTCClient: WebRTCClient
//
//    init(room: RoomAttrs,
//         currentUser: RoomMember,
//         webRTCClient: WebRTCClient = .init(iceServers: Config.defaultIceServers)) {
//
//        self.room = room
//        self.roomCountLikes = room.likes ?? 0
//        self.currentUser = currentUser
//        self.webRTCClient = webRTCClient
//        self.remoteVideoTrack = webRTCClient.remoteVideoTrack
//        self.webRTCClient.delegate = self
//        self.setMembers()
//        self.setTracks()
//    }
//
//    func disconnectAll() {
//        webRTCClient.leavePeerConnection()
//        RemoteCommandHelper.shared.removeNowPlayingItem()
//    }
//
//}
//
//// MARK: - WebRTC logic
//extension RoomViewModel {
//
//    func sendMessageToDataChannel(_ message: Message) {
//        do {
//            let data = try JSONHelper.encoder.encode(message)
//            webRTCClient.sendData(data)
//        } catch {
//            appAlert = .errors(errors: [error])
//        }
//    }
//
//    private func sendPlaylistToDataChannel(_ playlist: Playlist) {
//        do {
//            let data = try JSONHelper.encoder.encode(playlist)
//            webRTCClient.sendData(data)
//        } catch {
//            appAlert = .errors(errors: [error])
//        }
//    }
//
//    func startConnectWebRTC() async {
//
//        do {
//            let sdpOffer = try await webRTCClient.offer()
//            let sdpAnswer = try await initConnectionWithServer(.init(from: sdpOffer))
//            try await webRTCClient.set(remoteSdp: sdpAnswer)
//        } catch {
//            appAlert = .errors(errors: [error])
//        }
//
//    }
//
//    private func initConnectionWithServer(_ offer: SessionDescription) async throws -> RTCSessionDescription {
//        try await roomDataService.initConnection(for: room.id ?? "", offer: offer).rtcSessionDescription
//    }
//}
//
//// MARK: - Audio actions
//extension RoomViewModel {
//
//    func setAudio(_ audio: AudioItem) {
//        guard let id = room.id,
//              room.userIsOwner(for: currentUser.id) else { return }
//        Task {
//            do {
//                try await roomDataService.loadAudio(for: id, audioId: audio.id)
//                try await setAudioAction(.play)
//            } catch {
//                appAlert = .errors(errors: [error])
//            }
//        }
//    }
//
//    func togglePlay() {
//        Task {
//            if audioState.isPlay {
//                try await setAudioAction(.pause)
//            } else {
//                try await setAudioAction(.play)
//            }
//        }
//    }
//
//    func addPlaylist(_ audios: [AudioItem]) {
//        self.audios = audios
//        sendPlaylistToDataChannel(.init(files: audios.compactMap({$0.id})))
//    }
//
//    func updatePlaylist(_ status: PlaylistStatus) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else {return}
//            status.statuses.forEach { item in
//                guard let index = self.audios.firstIndex(where: {$0.id == item.id}) else {return}
//                self.audios[index].setStatus(item.status)
//            }
//        }
//    }
//
//    func startNextAudio() {
//        guard let index = audios.firstIndex(where: {$0.id == currentAudio?.id}),
//        currentAudio?.id != audios.last?.id else { return }
//        setAudio(audios[index + 1])
//    }
//
//    func startPreviewsAudio() {
//        guard let index = audios.firstIndex(where: {$0.id == currentAudio?.id}),
//        currentAudio?.id != audios.first?.id else { return }
//        setAudio(audios[index - 1])
//    }
//
//    var isDisabledNext: Bool {
//        audios.last?.id == currentAudio?.id
//    }
//
//    var isDisabledPreviews: Bool {
//        audios.first?.id == currentAudio?.id
//    }
//
//    func muteToggle() {
//        if isMute {
//            webRTCClient.unmuteAudio()
//        } else {
//            webRTCClient.muteAudio()
//        }
//        isMute.toggle()
//    }
//
//    func moveAudioTime() {
//        Task {
//            try await setAudioAction(.move, arg: "\(audioState.time)")
//        }
//    }
//
//    private func setAudioAction(_ action: RoomAction, arg: String = "") async throws {
//        guard let id = room.id else { return }
//        try await roomDataService.setRoomAction(for: id, action: action, arg: arg)
//    }
//}
//
//extension RoomViewModel {
//
//    var isOwner: Bool {
//        room.userIsOwner(for: currentUser.id)
//    }
//
//    func likeRoom() {
//        guard let id = room.id else { return }
//        Task {
//            try? await roomDataService.likeRoom(for: id)
//        }
//    }
//
//    func refreshRoom() {
//        guard let code = room.key else { return }
//        Task {
//            let room = try await roomDataService.findRoom(code)
//            self.room = room
//            self.setTracks()
//        }
//    }
//
//    func updateRoom(_ template: RoomTemplate) {
//        guard let id = room.id else {return}
//        Task {
//            do {
//                let image = template.createBase64Image()
//                try await roomDataService.updateRoom(for: id, name: template.name, image: image, isPrivate: template.isPrivateRoom)
//                refreshRoom()
//            } catch {
//                self.appAlert = .errors(errors: [error])
//            }
//        }
//    }
//
//    private func setMembers() {
//        guard let members = room.members else { return }
//        members.forEach {
//            guard let id = $0?.id, let user = $0?.fragments.userAttrs else { return }
//            self.members[id] = RoomMember(user: user)
//        }
//    }
//
//    private func setTracks() {
//        guard let files = room.playlist?.compactMap({$0?.fragments.fileAttrs}) else { return }
//        audios = files.compactMap({.init(file: $0, status: .ok)})
//    }
//}
//
//
//extension RoomViewModel: WebRTCClientDelegate {
//
//
//    func webRTCClient(_ client: WebRTCClient, didAdd stream: RTCMediaStream) {
//        DispatchQueue.main.async {
//            print(stream.videoTracks.count)
//            print(stream.videoTracks.compactMap({$0.trackId}))
//            self.remoteVideoTrack = stream.videoTracks.last
//        }
//    }
//
//
//    func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState) {
//        print("Connection status ->", state.statusValue.rawValue)
//        DispatchQueue.main.async {
//            self.status = state.statusValue
//        }
//    }
//
//    func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data) {
//        if let audioState = try? JSONHelper.decoder.decode(RoomPlayerState.self, from: data) {
//            self.onChangeAudio(audioState)
//        } else if let message = try? JSONHelper.decoder.decode(Message.self, from: data) {
//            self.onReceivedMessage(message)
//        } else if let playListState = try? JSONHelper.decoder.decode(PlaylistStatus.self, from: data) {
//            self.updatePlaylist(playListState)
//        }
//    }
//
//    func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate) {}
//
//    private func onReceivedMessage(_ message: Message) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            receivedMessage.send(message)
//
//            if message.type == .joined {
//                members[message.from.id] = message.from
//            } else if message.type == .leaving {
//                members.removeValue(forKey: message.from.id)
//            }
//        }
//    }
//
//    private func onChangeAudio(_ state: RoomPlayerState) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//
//            if roomCountLikes != state.likes {
//                roomCountLikes = state.likes
//            }
//
//            if state.fileId != audioState.id {
//                audioState = .init(from: state)
//                guard let currentAudio = audios.first(where: {$0.id == state.fileId}) else { return }
//                self.currentAudio = currentAudio
////                RemoteCommandHelper.shared.setupNowPlaying(RemoteCommandHelper.MediaItem(title: currentAudio.name ?? "No name", album: "Album", image: UIImage(systemName: "person")))
//
//            } else {
//                if !audioState.isPlay && state.status == .pause { return }
//                audioState.isPlay = state.status == .play
//                if !audioState.isScrubbingTime {
//                    audioState.time = state.current
//                }
//            }
//        }
//    }
//}


@MainActor
final class RoomViewModel: ObservableObject {

    @Published private(set) var remoteVideoTrack: RTCVideoTrack?
    
    @Published var refreshRemoteVideoTrack: Bool = false
    @Published var audioState = AudioUIState()
    @Published var appAlert: AppAlert?
    @Published private(set) var room: RoomAttrs
    @Published private(set) var roomCountLikes: Int = 0
    @Published private(set) var members: [String: RoomMember] = [:]
    @Published private(set) var videos = [VideoItem]()
    @Published private(set) var currentVideo: VideoItem?
    @Published private(set) var status: WebRTCStatus = .new
    @Published private(set) var isMute: Bool = false
    
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
    }

    func connectRoom() async {
        prepareWebRTCClient()
        await sentOfferToServerAndSetRemoteSdp()
    }

    private func prepareWebRTCClient(){
        webRTCClient = WebRTCClient()
        self.webRTCClient?.delegate = self
        remoteVideoTrack = webRTCClient?.remoteVideoTrack
        refreshRemoteVideoTrack = true

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
                self.room = newRoom
                try await setAudioAction(.play)
            } catch {
                appAlert = .errors(errors: [error])
            }
        }
    }

    func togglePlay() {
        Task {
            if audioState.isPlay {
                try await setAudioAction(.pause)
            } else {
                try await setAudioAction(.play)
            }
        }
    }

    func addPlaylist(_ videos: [VideoItem]) {
        self.videos = videos
        sendPlaylistToDataChannel(.init(files: videos.compactMap({$0.id})))
    }

    func updatePlaylist(_ status: PlaylistStatus) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            status.statuses.forEach { item in
                guard let index = self.videos.firstIndex(where: {$0.id == item.id}) else {return}
                self.videos[index].setStatus(item.status)
            }
        }
    }

    func startNextAudio() {
        guard let index = videos.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != videos.last?.id else { return }
        setVideo(videos[index + 1])
    }

    func startPreviewsAudio() {
        guard let index = videos.firstIndex(where: {$0.id == currentVideo?.id}),
        currentVideo?.id != videos.first?.id else { return }
        setVideo(videos[index - 1])
    }

    var isDisabledNext: Bool {
        videos.last?.id == currentVideo?.id
    }

    var isDisabledPreviews: Bool {
        videos.first?.id == currentVideo?.id
    }

    func muteToggle() {
//        if isMute {
//            webRTCClient.unmuteAudio()
//        } else {
//            webRTCClient.muteAudio()
//        }
//        isMute.toggle()
    }

    func moveAudioTime() {
        Task {
            try await setAudioAction(.move, arg: "\(audioState.time)")
        }
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
        #warning("TODO")
//        guard let files = room.?.compactMap({$0?.fragments.fileAttrs}) else { return }
//        videos = files.compactMap({.init(file: $0, status: .ok)})
    }
}


extension RoomViewModel: WebRTCClientDelegate {
    
    func webRTCClient(_ client: WebRTCClient, didStartReceivingOnTrack track: RTCVideoTrack) {
        DispatchQueue.main.async {
            self.remoteVideoTrack = track
        }
    }
    

    func webRTCClient(_ client: WebRTCClient, didAdd stream: RTCMediaStream) {
        
    }
    

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
            self.updatePlaylist(playListState)
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

            if roomCountLikes != state.likes {
                roomCountLikes = state.likes
            }

            if state.fileId != audioState.id {
                audioState = .init(from: state)
                guard let currentVideo = videos.first(where: {$0.id == state.fileId}) else { return }
                self.currentVideo = currentVideo
//                RemoteCommandHelper.shared.setupNowPlaying(RemoteCommandHelper.MediaItem(title: currentAudio.name ?? "No name", album: "Album", image: UIImage(systemName: "person")))

            } else {
                if !audioState.isPlay && state.status == .pause { return }
                audioState.isPlay = state.status == .play
                if !audioState.isScrubbingTime {
                    audioState.time = state.current
                }
            }
        }
    }
}

