//
//  RoomChatViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation
import SwiftUI
import Combine
import SchemaAPI

protocol ChatProviderDelegate: AnyObject {
    
    func onReceivedMessage(_ message: Message)
    
}

class RoomChatViewModel: ObservableObject, ChatProviderDelegate {
    
    @Published private(set) var messages = [Message]()
    @Published private(set) var selectedMessage: Message?
    @Published private(set) var lastMessageId: String = ""
    @Published private(set) var replyMessage: ReplyMessageAttrs?
    @Published var appAlert: AppAlert?
    
    private let chatService = RoomChatDataService()
    
    
    func selectMessage(_ message: Message?){
        withAnimation {
            selectedMessage = message
        }
    }
    
    func onReceivedMessage(_ message: Message) {
        DispatchQueue.main.async { [weak self] in
            withAnimation {
                self?.setOrUpdateMessage(message)
            }
        }
    }
    
    @MainActor
    func sendMessage(for id: String,
                     type: MessageType,
                     content: String) {
        Task {
            do {
                let messageInput = makeMassageInput(type: type, content: content, reply: replyMessage)
                resetReply()
                try await chatService.sendMessage(for: id, messageInput)
            } catch {
                appAlert = .errors(errors: [error])
            }
        }
    }
    
    func handleMessageContextAction(_ action: MessageContextAction,
                                    roomId: String) {
        switch action {
        case .reaction(let messageId, let reaction):
            sendReaction(roomId: roomId, messageId: messageId, reaction: reaction)
        case .copy:
            copyMessage()
        case .reply:
            setReplayMessage()
        case .report:
            guard let id = selectedMessage?.id else {return}
            hideMessage(roomId: roomId, messageId: id)
        }
        selectMessage(nil)
    }
    
    private func setOrUpdateMessage(_ message: Message) {
        if let index = messages.firstIndex(where: {$0.id == message.id}) {
            messages[index] = message
        } else {
            messages.insert(message, at: 0)
            lastMessageId = message.id
        }
    }
    
    private func copyMessage() {
        guard let text = selectedMessage?.text else {return}
        UIPasteboard.general.string = text
    }
    
    private func setReplayMessage() {
        guard let selectedMessage else { return }
        replyMessage = selectedMessage.makeReplyFromSelf()
    }
    
    private func sendReaction(roomId: String, messageId: String, reaction: String) {
        
    }
    
    private func hideMessage(roomId: String, messageId: String) {
        Task {
            do {
                try await chatService.hiddenMessage(roomId: roomId, messageId: messageId)
            } catch {
                appAlert = .errors(errors: [error])
            }
        }
    }
    
    private func makeMassageInput(type: MessageType,
                                  content: String,
                                  reply: ReplyMessageAttrs?) -> MessageInput {
        
        var replyId: String?
        
        if let reply, let id = reply.id {
            replyId = id
        }
        
        return .init(type: .some(.case(type)),
                     text: .init(stringLiteral: content),
                     replyMessage: replyId != nil ? .init(stringLiteral: replyId!) : .null)
        
    }
    
    func resetReply() {
        DispatchQueue.main.async { [weak self] in
            self?.replyMessage = nil
        }
    }
    
}
