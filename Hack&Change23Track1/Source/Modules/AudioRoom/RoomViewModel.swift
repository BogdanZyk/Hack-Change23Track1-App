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
    @Published private(set) var room: RoomAttrs
    @Published private(set) var roomCountLikes: Int = 0
    @Published private(set) var members: [String: RoomMember] = [:]
    @Published private(set) var status: WebRTCStatus = .new
    
    weak var chatDelegate: ChatProviderDelegate?
    weak var remotePlayerDelegate: PlayerRemoteProvider?
    
    let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    private(set) var webRTCClient: WebRTCClient?

    init(room: RoomAttrs,
         currentUser: RoomMember) {
        self.room = room
        self.roomCountLikes = room.likes ?? 0
        self.currentUser = currentUser
        self.setMembers()
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
        print("didReceiveData ->", String(data: data, encoding: .utf8))
        if let audioState = try? JSONHelper.decoder.decode(RoomPlayerState.self, from: data) {
            self.remotePlayerDelegate?.onChangePlayerState(audioState)
        } else if let message = try? JSONHelper.decoder.decode(Message.self, from: data) {
            self.chatDelegate?.onReceivedMessage(message)
            self.updateMembers(message)
        } else if let playListState = try? JSONHelper.decoder.decode(PlaylistStatus.self, from: data) {
//            self.updatePlaylistStatus(playListState)
        }
    }

    func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate) {}

    private func updateMembers(_ message: Message) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if message.type == .joined {
                members[message.from.id] = message.from
            } else if message.type == .leaving {
                members.removeValue(forKey: message.from.id)
            }
        }
    }
}

