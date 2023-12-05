//
//  BottomBarView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI
import Combine

struct BottomBarView: View {
    @State private var showStickersView: Bool = false
    @Binding var text: String
    var replyMessage: Message.ReplyMessage?
    let onSend: (Message.MessageContent) -> Void
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
                
                textFieldSection
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .foregroundColor(.primaryFont)
        .background(Color.primaryBg)
        .sheet(isPresented: $showStickersView) {
            StickersList {
                onSend(.sticker($0))
            }
            .presentationDetents([.fraction(0.35), .medium])
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(text: .constant("123"), replyMessage: .init(id: "1", text: "test", userName: "nik"),  onSend: { _ in })
    }
}



extension BottomBarView {
    private var textFieldSection: some View {
        HStack {
            
            Button {
                showStickersView.toggle()
            } label: {
                Image("sticker")
                    .resizable()
                    .frame(width: 28, height: 28)
            }

            TextField(text: $text) {
                Text("Message")
                    .foregroundColor(.secondaryGray)
            }
            .submitLabel(.send)
            .submitScope(text.isEmpty)
            .onSubmit {
                if !text.isEmpty {
                    onSend(.text(text))
                }
            }
            if !text.isEmpty {
                Button {
                    onSend(.text(text))
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .foregroundColor(.primaryPink)
                }
            }
        }
        .font(.primary())
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 16))
    }
}

extension BottomBarView {
    
    struct StickersList: View {
        @Environment(\.dismiss) private var dismiss
        @State private var stickers: [String] = []
        private let columns = Array(repeating: GridItem(.flexible()), count: 4)
        let onSelected: (String) -> Void
        var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    if !stickers.isEmpty {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(stickers, id: \.self) { item in
                                let url = "http://45.12.237.146" + item.replacingOccurrences(of: " ", with: "%20")

                                LazyNukeImage(fullPath: url)
                                    .frame(width: 75, height: 75)
                                    .onTapGesture {
                                        onSelected(url)
                                        dismiss()
                                    }
                            }
                        }
                    } else {
                        ProgressView()
                            .padding()
                    }
                }
                .padding()
            }
            .padding(.top)
            .background(Color.primaryBg.ignoresSafeArea())
            .task {
                if stickers.isEmpty {
                    let stickers = await RoomDataService().fetchStickers()
                    self.stickers = stickers
                }
            }
        }
    }
}

