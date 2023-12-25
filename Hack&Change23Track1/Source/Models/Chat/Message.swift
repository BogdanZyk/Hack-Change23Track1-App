//
//  Message.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation
import SchemaAPI

struct Message: Identifiable {
    
    let id: String
    let from: RoomMember
    var type: MessageType
    var text: String?
    var replyMessage: ReplyMessageAttrs?
    var reactions: [ReactionMessageAttrs] = []
    
    init(id: String, from: RoomMember, type: MessageType, text: String? = nil, replyMessage: ReplyMessageAttrs? = nil, reactions: [ReactionMessageAttrs] = []) {
        self.id = id
        self.from = from
        self.type = type
        self.text = text
        self.replyMessage = replyMessage
        self.reactions = reactions
    }
    
    init(attrs: MessageAttrs) {
        self.id = attrs.id ?? UUID().uuidString
        self.from = .init(messageUser: attrs.from?.fragments.messageUserAttrs)
        self.type = attrs.type?.value ?? .message
        self.text = attrs.text
        self.replyMessage = attrs.replyMessage?.fragments.replyMessageAttrs
        self.reactions = attrs.reactions?.compactMap({$0?.fragments.reactionMessageAttrs}) ?? []
    }
        
    enum MessageContent {
        case text(String), sticker(String)
        
        var content: String {
            switch self {
            case .text(let string):
                return string
            case .sticker(let string):
                return string
            }
        }
    }
    
    var content: String {
        switch type {
            
        case .joined:
            return "joined in room"
        case .leaving:
            return "leaving the room "
        case .message, .sticker:
            return text ?? ""
        case .hidden:
            return "Hidden message"
        }
    }
    
    func countReactions() -> [(reaction: ReactionMessageAttrs, count: Int)] {
        var counts: [ReactionMessageAttrs: Int] = [:]

        for reaction in reactions {
            counts[reaction, default: 0] += 1
        }

        return counts.map { (reaction: $0.key, count: $0.value) }
    }
}

extension Message {
    
    static let mockReply = Message(id: UUID().uuidString, from: .mock, type: .message, text: "Message", replyMessage: .init(id: UUID().uuidString, text: "Message 2", userName: "Nik"))
    
    static let mockMessage = Message(id: UUID().uuidString, from: .mock, type: .message, text: "Message", replyMessage: nil)
    
    static let mockMessageNotif = Message(id: UUID().uuidString, from: .mock, type: .joined, text: nil, replyMessage: nil)
    
    static let mockMessageWithReactions = Message(id: UUID().uuidString, from: .mock, type: .message, text: "Message", replyMessage: nil, reactions: [.init(reaction: "😍", from: .init(id: "1"))])
}

//
//extension MessageAttrs {
//    
//    static let mockReply = MessageAttrs(from: .init(avatar: "", id: "1", login: "Tester"), id: UUID().uuidString, reactions: [], replyMessage: .init(id: "1", text: "Reply message", userName: "Mike"), sticker: nil, text: "Message 1", type: .case(.message))
//    
//    static let mockMessage = MessageAttrs(from: .init(avatar: "", id: "1", login: "Tester"), id: UUID().uuidString, reactions: [], replyMessage: nil, sticker: nil, text: "Message 1", type: .case(.message))
//    
//    static let mockMessageNotif = MessageAttrs(from: .init(avatar: "", id: "1", login: "Tester"), id: UUID().uuidString, reactions: [], replyMessage: nil, sticker: nil, text: nil, type: .case(.joined))
//    
//    static let mockMessageWithReactions = MessageAttrs(from: .init(avatar: "", id: "1", login: "Tester"), id: UUID().uuidString, reactions: [.some(.init(reaction: "😍", from: .init(id: "1")))], replyMessage: nil, sticker: nil, text: nil, type: .case(.joined))
//    
//}
