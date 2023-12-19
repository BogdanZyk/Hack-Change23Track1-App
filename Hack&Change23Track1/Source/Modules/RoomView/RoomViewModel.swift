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
    @Published var isPresentedLeaveAlert: Bool = false
    @Published private(set) var room: RoomAttrs
    @Published private(set) var roomCountLikes: Int = 0
    @Published private(set) var members: [String: RoomMember] = [:]
    @Published var isConnected: Bool = false
    //@Published private(set) var status: WebRTCStatus = .new
    
    weak var chatDelegate: ChatProviderDelegate?
    weak var remotePlayerDelegate: PlayerRemoteProvider?
    
    let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    private var cancelBag = CancelBag()

    init(room: RoomAttrs,
         currentUser: RoomMember) {
        self.room = room
        self.roomCountLikes = room.likes ?? 0
        self.currentUser = currentUser
        self.setMembers()
    }
    
    #warning("connect to websocket for room")
    func connectRoom() async {
        isConnected = true
    }


    func disconnectAll() {
        
        RemoteCommandHelper.shared.removeNowPlayingItem()
    }
    
    func connectToWebsocket() {
        // handle connect loader
//        Network.shared.splitClient?.subscribePublisher(subscription: UpdateCurrentUserMutation(avatar: ""), queue: .global(qos: .userInteractive))
//            .sink(receiveCompletion: { completion in
//                switch completion {}
//            }, receiveValue: { result in
//                // hangel connect loader
//            })
//            .store(in: cancelBag)

        
//        let subs = Network.shared.splitClient?.subscribe(subscription: UpdateCurrentUserMutation(avatar: ""))
//
//        for await data in subs {
//
//        }
        
//        if let audioState = try? JSONHelper.decoder.decode(RoomPlayerState.self, from: data) {
//            self.remotePlayerDelegate?.onChangePlayerState(audioState)
//        } else if let message = try? JSONHelper.decoder.decode(Message.self, from: data) {
//            self.updateMembers(message)
//            self.chatDelegate?.onReceivedMessage(message)
//        }
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
        #warning("TODO members")
//        guard let members = room.members else { return }
//        members.forEach {
//            guard let id = $0?.id, let user = $0?.fragments.userAttrs else { return }
//            self.members[id] = RoomMember(user: user)
//        }
    }
}


extension RoomViewModel {
    
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

