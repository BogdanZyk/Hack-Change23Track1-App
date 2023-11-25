//
//  MessageContextMenu.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct MessageContextMenuView: View{
    var message: Message?
    let preferense: Dictionary<String, Anchor<CGRect>>.Element
    let onAction: (MessageContextAction) -> Void
    var body: some View{
        GeometryReader { proxy in
            let rect = proxy[preferense.value]
            let isBottom = (rect.minY) > proxy.size.height / 2
            MessageContextBody(message: message, onAction: onAction)
                .id(message?.id ?? UUID().uuidString)
                .frame(width: rect.width)
                .offset(x: rect.minX, y: isBottom ? (proxy.size.height / 2.5) : rect.minY)
                .transition(.asymmetric(insertion: .identity, removal: .offset(x: 1)))
        }
    }
}

extension MessageContextMenuView{
    
    
    struct MessageContextBody: View {
        var message: Message?
        let onAction: (MessageContextAction) -> Void
        var body: some View {
            if let message = message {
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 10) {
                        UserAvatarView(image: message.from.avatar,
                                       userName: message.from.login,
                                       size: .init(width: 40, height: 40),
                                       withStroke: false)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(message.from.login)
                                .font(.body.bold())
                            Text(message.content)
                                .font(.body.weight(.light))
                                .lineLimit(2)
                        }
                    }
                    .padding(10)
                    .hLeading()
                    .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 8))
                    HStack {
                        ForEach([MessageContextAction.copy, .reply, .report], id: \.id) { type in
                            Button {
                                onAction(type)
                            } label: {
                                VStack(spacing: 4) {
                                    Text(type.title)
                                    Image(systemName: type.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                }
                                .foregroundColor(type.id == 3 ? .red.opacity(0.8) : .primaryFont)
                                .font(.body)
                                .hCenter()
                            }
                        }
                    }
                    .padding(10)
                    .hLeading()
                    .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 8))
                    EmojiReactionView { reaction in
                        onAction(.reaction(message, reaction.title))
                    }
                }
                .foregroundColor(.primaryFont)
                .frame(width: 300)
            }
        }
    }
}

struct MessageContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.primaryBg
            MessageContextMenuView.MessageContextBody(message: Message.mockMessage, onAction: {_ in })
        }
        
    }
}

enum MessageContextAction{
    case reaction(Message, String), copy, reply, report
    
    var id: Int {
        switch self {
        case .reaction:
            return 0
        case .copy:
            return 1
        case .reply:
            return 2
        case .report:
            return 3
        }
    }
    
    var title: String {
        switch self {
        case .reaction:
            return ""
        case .copy:
        return "Copy"
        case .reply:
            return "Reply"
        case .report:
            return "Report"
        }
    }
    
    var image: String {
        switch self {
        case .reaction:
            return ""
        case .copy:
            return "doc.on.doc.fill"
        case .reply:
            return "arrowshape.turn.up.left.fill"
        case .report:
            return "exclamationmark.shield.fill"
        }
    }
}

struct BoundsPreferece: PreferenceKey {
    
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()){$1}
    }
}



