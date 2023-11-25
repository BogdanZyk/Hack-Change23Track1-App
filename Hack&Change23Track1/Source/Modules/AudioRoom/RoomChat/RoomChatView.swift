//
//  RoomChatView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct RoomChatView: View {
    @FocusState var isFocused: Bool
    @ObservedObject var roomVM: RoomViewModel
    @ObservedObject var chatVM: RoomChatViewModel
    @State private var message: String = ""
    @State private var hiddenDownButton: Bool = true
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                messagesList
            }
            .flippedUpsideDown()
            .padding(.horizontal, 8)
            .overlay(alignment: .bottomTrailing) {
                downActionButton(proxy)
            }
            .onReceive(roomVM.receivedMessage) {
                onReceivedNewMessage($0, proxy: proxy)
            }
        }
        .foregroundColor(.white)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            bottomBarSection
        }
        .background(Color.primaryBg)
//        .overlayPreferenceValue(BoundsPreferece.self) {
//            contextMenu($0)
//        }
        .simultaneousGesture(
        TapGesture()
            .onEnded{ _ in
                isFocused = false
            }
        )
    }
}

struct RoomChatView_Previews: PreviewProvider {
    static var previews: some View {
        RoomChatView(roomVM: .init(room: .mock, currentUser: .mock), chatVM: .init())
    }
}

extension RoomChatView {
    
    private func onReceivedNewMessage(_ message: Message, proxy: ScrollViewProxy) {
        withAnimation {
            chatVM.setOrUpdateMessage(message)
        }
        if !hiddenDownButton {
            scrollToDown(message.id, proxy: proxy)
        }
    }
}

extension RoomChatView {
    
    
    private var bottomBarSection: some View {
        BottomBarView(text: $message,
                      replyMessage: chatVM.replyMessage) {
            createAndSendMessage($0)
        }
        .focused($isFocused)
    }
    
   private var messagesList: some View {
        LazyVStack(spacing: 6){
            ForEach(chatVM.messages) { message in
                makeMessageRow(message)
            }
        }
    }
    
    private func scrollToDown(_ id: String?, proxy: ScrollViewProxy) {
        guard let id else {return}
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.15)) {
                proxy.scrollTo(id)
            }
        }
    }
    
    private func makeMessageRow(_ message: Message) -> some View {
        MessageRowView(message: message,
                       userIsSender: message.from.id == roomVM.currentUser.id,
                       onLongPressGesture: {
            isFocused = false
            chatVM.selectMessage(message)
        })
//        .anchorPreference(key: BoundsPreferece.self, value: .bounds, transform: { anchor in
//            return [message.id : anchor]
//        })
        .flippedUpsideDown()
        .onAppear {
            hiddenOrUnhiddenDownButton(message.id, isHidden: true)
        }
        .onDisappear{
            hiddenOrUnhiddenDownButton(message.id, isHidden: false)
        }
    }
}



extension RoomChatView {
    
    @ViewBuilder
    private func contextMenu(_ values: [String: Anchor<CGRect>]) -> some View {
        if let selectedMessage = chatVM.selectedMessage, let preferense = values.first(where: {$0.key == selectedMessage.id}) {
            ZStack {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        chatVM.selectMessage(nil)
                    }
//                MessageContextMenuView(message: selectedMessage,
//                                       preferense: preferense,
//                                       onAction: hadleMessageContextAction)
            }
            .transition(.opacity)
        }
    }
    
    @ViewBuilder
    private func downActionButton(_ proxy: ScrollViewProxy) -> some View {
        if !hiddenDownButton {
            Image(systemName: "chevron.down")
                .padding(10)
                .background(Color.secondary, in: Circle())
                .padding(8)
                .onTapGesture {
                    scrollToDown(chatVM.messages.first?.id, proxy: proxy)
                }
                .transition(.scale.combined(with: .opacity))
        }
    }
    
    func hiddenOrUnhiddenDownButton(_ messageId: String, isHidden: Bool) {
        if messageId == chatVM.messages.first?.id {
            withAnimation {
                hiddenDownButton = isHidden
            }
        }
    }
}

extension RoomChatView {
    
    private func createAndSendMessage(_ content: String) {
        message = ""
        isFocused = false
        let message = Message(id: UUID().uuidString,
                              from: roomVM.currentUser,
                              type: .message,
                              text: content,
                              replyMessage: chatVM.replyMessage)
        chatVM.resetReply()
        roomVM.sendMessageToDataChannel(message)
    }
    
//    private func hadleMessageContextAction(_ action: MessageContextAction) {
//        switch action {
//        case .reaction(let oldMessage, let reaction):
//            var newMessage = oldMessage
//            newMessage.addedReaction(from: roomVM.currentUser, reaction: reaction)
//            roomVM.sendMessageToDataChannel(message)
//        case .copy:
//            viewModel.copyMessage()
//        case .reply:
//            viewModel.setReplayMessage()
//        case .report:
//            guard var selectedMessage = viewModel.selectedMessage else {return}
//            selectedMessage.type = .hidden
//            roomVM.sendMessageToDataChannel(message)
//        }
//        viewModel.selectMessage(nil)
//    }
    
}
