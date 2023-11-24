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

    @Published var audioState = AudioUIState()
    @Published var appAlert: AppAlert?
    @Published private(set) var room: RoomAttrs
    @Published private(set) var roomCountLikes: Int = 0
    @Published private(set) var members: [String: RoomMember] = [:]
    @Published private(set) var audios = [FileAttrs]()
    @Published private(set) var currentAudio: FileAttrs?
    @Published private(set) var status: WebRTCStatus = .new
    @Published private(set) var isMute: Bool = false
    
    private(set) var receivedMessage = PassthroughSubject<Message, Never>()

    let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    private let webRTCClient: WebRTCClient
    
    init(room: RoomAttrs,
         currentUser: RoomMember,
         webRTCClient: WebRTCClient = .init(iceServers: Config.defaultIceServers)) {
        
        self.room = room
        self.roomCountLikes = room.likes ?? 0
        self.currentUser = currentUser
        self.webRTCClient = webRTCClient
        self.webRTCClient.delegate = self
        self.setMembers()
    }
    
    var isOwner: Bool {
        room.userIsOwner(for: currentUser.id)
    }
    
    func disconnectAll() {
        webRTCClient.leavePeerConnection()
        RemoteCommandHelper.shared.removeNowPlayingItem()
    }
    
}


// MARK: - WebRTC logic

extension RoomViewModel {
    
    func sendMessageToDataChannel(_ message: Message) {
        do {
            let data = try JSONHelper.encoder.encode(message)
            webRTCClient.sendData(data)
        } catch {
            appAlert = .errors(errors: [error])
        }
    }
    
     func startConnectWebRTC() {
        Task {
            do {
                let sdpOffer = try await webRTCClient.offer()
                let sdpAnswer = try await initConnectionWithServer(.init(from: sdpOffer))
                try await webRTCClient.set(remoteSdp: sdpAnswer)
            } catch {
                appAlert = .errors(errors: [error])
            }
        }
    }
    
    private func initConnectionWithServer(_ offer: SessionDescription) async throws -> RTCSessionDescription {
        try await roomDataService.initConnection(for: room.id ?? "", offer: offer).rtcSessionDescription
    }
}

// MARK: - Audio actions
extension RoomViewModel {
    
    func fetchAudios() async {
        let audios = try? await roomDataService.fetchAudios()
        self.audios = audios ?? []
    }
    
    func setAudio(_ audio: FileAttrs) {
        guard let id = room.id, let audioId = audio.id else { return }
        Task {
            do {
                try await roomDataService.loadAudio(for: id, audioId: audioId)
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
    
    func startNextAudio() {
        guard let index = audios.firstIndex(where: {$0.id == currentAudio?.id}),
        currentAudio?.id != audios.last?.id else { return }
        setAudio(audios[index + 1])
    }
    
    func startPreviewsAudio() {
        guard let index = audios.firstIndex(where: {$0.id == currentAudio?.id}),
        currentAudio?.id != audios.first?.id else { return }
        setAudio(audios[index - 1])
    }
    
    var isDisabledNext: Bool {
        audios.last?.id == currentAudio?.id
    }
    
    var isDisabledPreviews: Bool {
        audios.first?.id == currentAudio?.id
    }
    
    func muteToggle() {
        if isMute {
            webRTCClient.unmuteAudio()
        } else {
            webRTCClient.muteAudio()
        }
        isMute.toggle()
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
    
    func likeRoom() {
        guard let id = room.id else { return }
        Task {
            try? await roomDataService.likeRoom(for: id)
        }
    }
    
    private func setMembers() {
        guard let members = room.members else { return }
        members.forEach {
            guard let id = $0?.id, let user = $0?.fragments.userAttrs else { return }
            self.members[id] = RoomMember(user: user)
        }
    }
}


extension RoomViewModel: WebRTCClientDelegate {
    
    func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState) {
        print("Connection status ->", state.statusValue.rawValue)
        DispatchQueue.main.async {
            self.status = state.statusValue
        }
    }
    
    func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data) {
        if let audioState = try? JSONHelper.decoder.decode(RoomPlayerState.self, from: data) {
            self.onChangeAudio(audioState)
        } else if let message = try? JSONHelper.decoder.decode(Message.self, from: data) {
            self.onReceivedMessage(message)
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
                guard let currentAudio = audios.first(where: {$0.id == state.fileId}) else { return }
                self.currentAudio = currentAudio
                RemoteCommandHelper.shared.setupNowPlaying(RemoteCommandHelper.MediaItem(title: currentAudio.name ?? "No name", album: "Album", image: UIImage(systemName: "person")))
                
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
