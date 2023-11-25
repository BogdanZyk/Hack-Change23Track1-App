//
//  MessageRowView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

extension RoomChatView {
    
    struct MessageRowView: View {
        let message: Message
        let userIsSender: Bool
        let onLongPressGesture: () -> Void
        var body: some View {
            HStack(alignment: userIsSender ? .center : .top, spacing: 10) {
                makeMessageView()
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 2)
            .frame(maxWidth: .infinity, alignment: userIsSender ? .trailing : .leading)
            .foregroundColor(.primaryFont)
            .onTapGesture { }
            .onLongPressGesture {
                if message.type == .message || message.type == .sticker {
                    onLongPressGesture()
                }
            }
        }
        
        private func makeMessageView() -> some View {
            Group {
                switch message.type {
                    
                case .hidden:
                    Text(message.content)
                        .opacity(0.5)
                        .hCenter()
                case .joined, .leaving:
                    
                    HStack {
                        Text(userIsSender ? "You" : message.from.login).bold()
                        Text(message.content)
                    }
                    .hCenter()
                    .opacity(0.5)
                    
                case .message:
                    HStack(alignment: .bottom) {
                        avatarView
                        VStack(alignment: .leading, spacing: 4) {
                            nickname
                            replyMessage
                            content
                            reactionSection
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .background(Color.primaryGray)
                        .cornerRadius(5)
                        .roundedCorner(16, corners: corners)
                    }
                case .sticker:
                    HStack(alignment: .bottom) {
                        avatarView
                        VStack(alignment: .leading, spacing: 4) {
                            replyMessage
                            LazyNukeImage(fullPath: message.sticker)
                                .frame(width: 90, height: 90)
                            reactionSection
                        }
                    }
                    .containerShape(Rectangle())
                }
            }
        }
        
        @ViewBuilder
        private var avatarView: some View {
            if !userIsSender {
                UserAvatarView(image: message.from.avatar,
                               userName: message.from.login,
                               size: .init(width: 40, height: 40),
                               withStroke: userIsSender)
            }
        }
        
        private var content: some View {
            Text(message.content)
                .font(.primary())
        }
        
        @ViewBuilder
        private var nickname: some View {
            if !userIsSender {
                Text(message.from.login)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.purple)
            }
        }
        
        private var corners: UIRectCorner {
            if userIsSender {
                return [.bottomLeft, .topLeft, .topRight]
            } else {
                return [.bottomRight, .topLeft, .topRight]
            }
        }
        
        @ViewBuilder
        private var replyMessage: some View {
            if let reply = message.replyMessage {
                VStack(alignment: .leading, spacing: 2) {
                    Text(reply.userName)
                        .fontWeight(.semibold)
                    Text(reply.text)
                }
                .font(.small())
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .lineLimit(1)
                .background(Color.secondaryGray.opacity(0.2), in: RoundedRectangle(cornerRadius: 5))
            }
        }
        
        private var reactionSection: some View {
            HStack(spacing: 6) {
                let reactions = Array(message.countReactions().prefix(5))
                ForEach(reactions.indices, id: \.self) { index in
                    HStack {
                        HStack(spacing: 5) {
                            Text(reactions[index].reaction)
                            Text("\(reactions[index].count)")
                        }
                        .font(.system(size: 15))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.secondary.opacity(0.3), in: Capsule())
                    }
                    .transition(.scale)
                }
            }
        }
    }
}


struct RoomChatView2_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoomChatView.MessageRowView(message: .mockReply,
                                        userIsSender: false,
                                        onLongPressGesture: {})
            
            RoomChatView.MessageRowView(message: .mockReply,
                                        userIsSender: true,
                                        onLongPressGesture: {})
            
            RoomChatView.MessageRowView(message: .mockMessage,
                                        userIsSender: true,
                                        onLongPressGesture: {})
            
            RoomChatView.MessageRowView(message: .mockMessage,
                                        userIsSender: false,
                                        onLongPressGesture: {})
            
            RoomChatView.MessageRowView(message: .mockMessageWithReactions,
                                        userIsSender: false,
                                        onLongPressGesture: {})
            
            RoomChatView.MessageRowView(message: .mockMessageNotif,
                                        userIsSender: false,
                                        onLongPressGesture: {})
        }
        .padding()
        .background(Color.primaryBg)
    }
}

