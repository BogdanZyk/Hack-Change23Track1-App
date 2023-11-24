//
//  JoinInRoomView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct JoinInRoomView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = CreateRoomViewModel()
    @State private var room: RoomAttrs?
    @State private var code: String = ""
    let onJoin: (RoomAttrs) -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            navBarView
            codeSection
            findRoomSection
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.primaryBg)
        .foregroundColor(.primaryFont)
        .appAlert($viewModel.appAlert)
        .onChange(of: code) {
           findRoom($0)
        }
    }
}

struct JoinInRoomView_Previews: PreviewProvider {
    static var previews: some View {
        JoinInRoomView(viewModel: .init(), onJoin: {_ in})
    }
}

extension JoinInRoomView {
    
    private var navBarView: some View {
        Text("Join an room")
            .font(.xxLarge())
            .hCenter()
            .overlay(alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.large())
                }
            }
            .padding(.top)
    }
    
    private var codeSection: some View {
        PrimaryTextField(text: $code, label: "Code", title: "Room Code")
    }
    
    @ViewBuilder
    private var findRoomSection: some View {
        if let room {
            VStack(spacing: 24) {
                RoomRowView(room: room)
                joinButton(room)
            }
        } else if viewModel.showLoader {
            ProgressView()
                .hCenter()
        }
    }
    
    private func joinButton(_ room: RoomAttrs) -> some View{
        PrimaryButton(label: "Join",
                      isDisabled: false,
                      isLoading: false) {
            dismiss()
            onJoin(room)
        }
                      .padding(.bottom)
    }
    
    private func findRoom(_ value: String){
        if value.count >= 6 {
            Task {
                guard let room = await viewModel.findRoom(value) else { return }
                self.room = room
            }
        } else if value.isEmpty {
            room = nil
        }
    }
}
