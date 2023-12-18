//
//  BottomBarView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI
import Combine

struct BottomBarView: View {
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
                makeStickersSheet()
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
    
    private func makeStickersSheet() {
        let vc = UIHostingController(rootView: StickersList(onSelected: {onSend(.sticker($0))}))
        if let sheet = vc.sheetPresentationController {
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.detents = [.medium(), .large()]
        }
        UIApplication.navigationTopViewController()?.present(
            vc, animated: true, completion: nil
        )
    }
}

extension BottomBarView {
    
    struct StickersList: View {
        @Environment(\.dismiss) private var dismiss
        @State private var stickers: [String] = []
        private let columns = Array(repeating: GridItem(.flexible()), count: 4)
        let onSelected: (String) -> Void
        var body: some View {
            VStack(spacing: 0) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primaryFont)
                }
                .hLeading()
                .padding()
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
            }
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


//struct BottomSheet<Content: View>: View {
//
//    @State private var showSheet: Bool = false
//    @State private var movingOffset: CGFloat = .zero
//    @State private var currentHeight: CGFloat = .zero
//    let smallHeight: CGFloat = 300
//    @Binding var isOpen: Bool
//    let maxHeight: CGFloat
//    let minHeight: CGFloat
//    let content: Content
//
//    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
//        self.minHeight = maxHeight
//        self.maxHeight = maxHeight
//        self.content = content()
//        self._isOpen = isOpen
//    }
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            Color.black
//                .opacity(0.3)
//                .ignoresSafeArea()
//                .onTapGesture {
//                    hiddenSheet()
//                }
//                .onAppear {
//                    withAnimation {
//                        showSheet = true
//                    }
//                }
//            if showSheet {
//                content
//                    .allFrame()
//                    .roundedCorner(
//                        16, corners: [.topLeft, .topRight])
//                    .frame(maxHeight: maxHeight, alignment: .bottom)
//                    .transition(.move(edge: .bottom))
//                    .offset(y: movingOffset)
//                    .gesture(
//                        DragGesture().onChanged({ drag in
//
//                            movingOffset = max((drag.translation.height  + currentHeight), 0)
//
////                            if movingOffset >= 0 {
////                                movingOffset = drag.translation.height  + currentHeight
////                            }
//
//
//                        }).onEnded({ drag in
//                            withAnimation(.spring(dampingFraction: 0.7)) {
//                                if movingOffset > -20 {
//                                    movingOffset = 0.0
//                                }
//                                if drag.translation.height > 80 {
//                                    movingOffset = smallHeight
//                                }
//                                currentHeight = movingOffset
//                            }
//                            if drag.translation.height > 250 {
//                                hiddenSheet()
//                            }
//                        })
//                    )
//            }
//        }
//        .ignoresSafeArea()
//        .animation(.easeInOut, value: isOpen)
//        .onChange(of: isOpen) { isOpen in
//            withAnimation {
//                showSheet = isOpen
//            }
//        }
//    }
//
//    private func hiddenSheet() {
//        withAnimation(.easeInOut(duration: 0.2)) {
//            showSheet = false
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            withAnimation {
//                isOpen = false
//            }
//        }
//    }
//}
//
//fileprivate struct CustomSheetModifier<SheetContent: View>: ViewModifier {
//    @Binding var isOpen: Bool
//    let maxHeight: CGFloat
//    let sheetContent: SheetContent
//    func body(content: Content) -> some View {
//        ZStack(alignment: .bottom) {
//            content
//
//            if isOpen {
//                BottomSheet(isOpen: $isOpen, maxHeight: maxHeight) {
//                    sheetContent
//                }
//                .zIndex(100)
//            }
//        }
//    }
//}
//
//extension View {
//    func customSheet<Content: View>(isOpen: Binding<Bool>,
//                     maxHeight: CGFloat,
//                    @ViewBuilder content: @escaping () -> Content) -> some View {
//        self.modifier(CustomSheetModifier(isOpen: isOpen, maxHeight: maxHeight, sheetContent: content()))
//    }
//}

