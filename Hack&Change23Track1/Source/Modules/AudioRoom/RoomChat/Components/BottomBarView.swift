//
//  BottomBarView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct BottomBarView: View {
    @Binding var text: String
    var replyMessage: Message.ReplyMessage?
    let onSend: (String) -> Void
    var body: some View {
        VStack(spacing: 4){
            Divider()
            VStack(alignment: .leading, spacing: 10) {
                if let replyMessage {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                            .font(.title3)
                        VStack(alignment: .leading, spacing: 1){
                            Text(replyMessage.userName).bold()
                            Text(replyMessage.text)
                        }
                    }
                    .lineLimit(1)
                    .hLeading()
                }
                
                HStack {
                    TextField(text: $text) {
                        Text("Message")
                            .foregroundColor(.secondaryGray)
                    }
                    if !text.isEmpty {
                        Button {
                            withAnimation(.easeIn(duration: 0.2)) {
                                onSend(text)
                            }
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .font(.title3)
                                .foregroundColor(.primaryPink)
                        }
                    }
                }
                .font(.primary())
                .padding(.vertical, 14)
                .padding(.horizontal, 18)
                .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .foregroundColor(.primaryFont)
        .background(Color.primaryBg)
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(text: .constant("123"), replyMessage: .init(id: "1", text: "test", userName: "nik"),  onSend: { _ in })
    }
}
