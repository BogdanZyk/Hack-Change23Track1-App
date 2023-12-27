//
//  RoomViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import Combine
import SchemaAPI

@MainActor
final class RoomViewModel: ObservableObject {
    
    @Published var appAlert: AppAlert?
    @Published private(set) var room: RoomAttrs
    @Published private(set) var roomCountLikes: Int = 0
    @Published private(set) var members: [String: RoomMember] = [:]
    @Published private(set) var state: RoomState = .connected
    
    weak var chatDelegate: ChatProviderDelegate?
    
    let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    private let roomChatService = RoomChatDataService()
    private var cancelBag = CancelBag()

    init(room: RoomAttrs,
         currentUser: RoomMember) {
        self.room = room
        self.roomCountLikes = room.likes ?? 0
        self.currentUser = currentUser
        self.getMembers()
    }
    
    deinit {
        cancelBag.cancel()
    }
    
    func connectRoom() {
        startRoomChatSubscription()
    }

    func disconnectAll() {
        cancelBag.cancel()
        RemoteCommandHelper.shared.removeNowPlayingItem()
    }
    
    private func startRoomChatSubscription() {
        guard let id = room.id else { return }
        roomChatService.subscribeToRoomChat(for: id)
            .sink { [weak self] completion in
                guard let self = self else {return}
                handleCombineCompletion(completion)
            } receiveValue: {
                self.handleChatData($0)
            }
            .store(in: cancelBag)
    }
    
    private func fetch() {
        Task {
            let data = try? await roomDataService.getMessages(for: room.id!)
        }
    }
}

// MARK: - Chat handler
extension RoomViewModel {
    
    private func handleChatData(_ subs: SubscribeChatSubscription.Data.SubscribeChat?) {
        //changeConnection(
        print(subs)
        updateLikes(subs?.roomReaction)
        if let messageAttrs = subs?.message?.fragments.messageAttrs {
            let newMessage = Message(attrs: messageAttrs)
            chatDelegate?.onReceivedMessage(newMessage)
            updateMembersIfNeeded(newMessage.from, type: newMessage.type)
        }
    }
    
    private func handleCombineCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error)
            DispatchQueue.main.async {
                self.appAlert = .errors(errors: [error])
            }
        }
    }
    
    private func changeConnection() {
        if state != .connected {
            DispatchQueue.main.async {
                self.state = .connected
            }
        }
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

    private func getMembers() {
        #warning("TODO members")
//        guard let members = room.members else { return }
//        members.forEach {
//            guard let id = $0?.id, let user = $0?.fragments.userAttrs else { return }
//            self.members[id] = RoomMember(user: user)
//        }
    }
}


extension RoomViewModel {
    
    private func updateMembersIfNeeded(_ member: RoomMember?, type: MessageType?) {
        guard let member, let type else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if type == .joined {
                members[member.id] = member
            } else if type == .leaving {
                members.removeValue(forKey: member.id)
            }
        }
    }
    
    private func updateLikes(_ likes: Int?) {
        guard let likes else { return }
        DispatchQueue.main.async { [weak self] in
            self?.roomCountLikes = likes
        }
    }
}

enum RoomState: Int {
    case connected, connecting, error
}
