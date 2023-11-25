//
//  AudioRoomView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct AudioRoomView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var chatVM = RoomChatViewModel()
    @StateObject private var viewModel: RoomViewModel
    @State private var tab: RoomTab = .chat
    @FocusState private var isFocused: Bool
    init(room: RoomAttrs, currentUser: RoomMember) {
        self._viewModel = StateObject(
            wrappedValue: RoomViewModel(room: room, currentUser: currentUser)
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                if !isFocused {
                    topBarView
                }
                playerView
                tabButtons
            }
            .overlay {
                contextOverlay
            }
            tabViewSection
        }
        .foregroundColor(.primaryFont)
        .background(Color.primaryBg.ignoresSafeArea())
        .appAlert($viewModel.appAlert)
        .task {
            await viewModel.startConnectWebRTC()
            await viewModel.fetchAudios()
        }
        .overlay {
            if !viewModel.status.isConnected {
                loader
            }
        }
    }
}

struct AudioRoomView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRoomView(room: .mock, currentUser: .mock)
    }
}

extension AudioRoomView {
    
    private var topBarView: some View {
        Text(viewModel.room.name ?? "no key")
            .font(.primary())
            .hCenter()
            .lineLimit(1)
            .overlay {
                HStack {
                    Button {
                        viewModel.disconnectAll()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                    Spacer()
                    if viewModel.isOwner {
                        Button {
                            
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    } else {
                        Button {
                            ShareUtils.shareRoom(for: viewModel.room.name)
                        } label: {
                            Image(systemName: "arrowshape.turn.up.forward.fill")
                        }
                    }
                }
                .font(.title2)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
    }
    
    private var playerView: some View {
        PlayerView(showFullVersion: !isFocused,
                   isDisabledControls: !viewModel.isOwner,
                   viewModel: viewModel)
    }
    
    private var tabViewSection: some View {
        RoomTabView(tab: $tab,
                    viewModel: viewModel,
                    chatVM: chatVM,
                    isFocused: _isFocused)
    }
    
    @ViewBuilder
    private var tabButtons: some View {
        TabButtons(tab: $tab)
    }
    
    
    enum RoomTab: String, CaseIterable {
        case chat, playlist, members
    }
    
    private var loader: some View {
        VStack {
            Text("Connecting")
            ProgressView()
                .tint(.white)
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 12))
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var contextOverlay: some View {
        if chatVM.selectedMessage != nil {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    chatVM.selectMessage(nil)
                }
        }
    }
}
