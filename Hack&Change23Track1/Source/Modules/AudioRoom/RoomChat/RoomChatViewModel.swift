//
//  RoomChatViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation
import SwiftUI

class RoomChatViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    @Published private(set) var selectedMessage: Message?
    @Published private(set) var replyMessage: Message.ReplyMessage?
    
    func selectMessage(_ message: Message?){
        withAnimation {
            selectedMessage = message
        }
    }
    
    func setOrUpdateMessage(_ message: Message) {
        if let index = messages.firstIndex(where: {$0.id == message.id}) {
            messages[index] = message
        } else {
            messages.insert(message, at: 0)
        }

    }
    
    func copyMessage() {
        print("copy")
    }
    
    func setReplayMessage() {
        guard let selectedMessage else { return }
        replyMessage = .init(id: selectedMessage.id, text: selectedMessage.content, userName: selectedMessage.from.login)
    }
    
    func resetReply() {
        replyMessage = nil
    }
    
}
