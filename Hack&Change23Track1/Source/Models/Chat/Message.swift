//
//  Message.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation

struct Message: Identifiable, Codable {
    
    let id: String
    let from: RoomMember
    var type: MessageType
    var text: String?
    var replyMessage: ReplyMessage?
    var reactions: [MessageReaction] = []
    var sticker: String?
    
    enum MessageType: String, Codable {
        case joined, leaving, message, sticker, hidden
    }
    
    enum MessageContent {
        case text(String), sticker(String)
    }
    
    var content: String {
        switch type {
            
        case .joined:
            return "joined in room"
        case .leaving:
            return "leaving the room "
        case .message:
            return text ?? ""
        case .hidden:
            return "Hidden message"
        case .sticker:
            return ""
        }
    }
    
    func countReactions() -> [(reaction: String, count: Int)] {
        var counts: [String: Int] = [:]

        for reaction in reactions {
            counts[reaction.reaction, default: 0] += 1
        }

        return counts.map { (reaction: $0.key, count: $0.value) }
    }
    
    mutating func addedReaction(from user: RoomMember, reaction: String) {
        reactions.removeAll(where: {$0.from.id == user.id})
        reactions.append(.init(from: user, reaction: reaction))
    }
    
    mutating func removeReaction(from id: String) {
        reactions.removeAll(where: {$0.from.id == id})
    }
}

extension Message {
    
    struct ReplyMessage: Codable {
        let id: String
        let text: String
        let userName: String
    
    }
    
    struct MessageReaction: Codable {
        let from: RoomMember
        let reaction: String
    
        static let mockReaction = MessageReaction(from: .mock, reaction: "🥰")
        static let mockReaction2 = MessageReaction(from: .mock, reaction: "😡")
    }
}


extension Message {
    
    static let mockReply = Message(id: UUID().uuidString, from: .mock, type: .message, text: "Message", replyMessage: .init(id: UUID().uuidString, text: "Message 2", userName: "Nik"))
    
    static let mockMessage = Message(id: UUID().uuidString, from: .mock, type: .message, text: "Message", replyMessage: nil)
    
    static let mockMessageNotif = Message(id: UUID().uuidString, from: .mock, type: .joined, text: nil, replyMessage: nil)
    
    static let mockMessageWithReactions = Message(id: UUID().uuidString, from: .mock, type: .message, text: "Message", replyMessage: nil, reactions: [.mockReaction])
}
