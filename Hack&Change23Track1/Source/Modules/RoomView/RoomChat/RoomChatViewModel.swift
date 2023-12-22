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
    
    func createAndSendMessage(_ content: Message.MessageContent,
                              currentUser: RoomMember) {
        var message = Message(id: UUID().uuidString,
                              from: currentUser,
                              type: .message,
                              text: "",
                              replyMessage: replyMessage)
        
        switch content {
        case .text(let text):
            message.type = .message
            message.text = text
        case .sticker(let sticker):
            message.type = .sticker
            message.sticker = sticker
        }
        
        resetReply()
       // sendMessage(webRTCClient: webRTCClient, message)
    }
    
    func handleMessageContextAction(_ action: MessageContextAction,
                                            currentUser: RoomMember) {
        switch action {
        case .reaction(let oldMessage, let reaction):
            var newMessage = oldMessage
            newMessage.addedReaction(from: currentUser.id, reaction: reaction)
            //sendMessage(webRTCClient: webRTCClient, newMessage)
        case .copy:
            copyMessage()
        case .reply:
            setReplayMessage()
        case .report:
            guard var selectedMessage = selectedMessage else {return}
            selectedMessage.type = .hidden
           // sendMessage(webRTCClient: webRTCClient, selectedMessage)
        }
        selectMessage(nil)
    }
    
    func sendMessage(_ message: Message) {
//        guard let data = try? JSONHelper.encoder.encode(message) else { return }
//        webRTCClient.sendData(data)
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
        replyMessage = .init(id: selectedMessage.id, text: selectedMessage.content, userName: selectedMessage.from.login)
    }
    
    func resetReply() {
        replyMessage = nil
    }
    
}
