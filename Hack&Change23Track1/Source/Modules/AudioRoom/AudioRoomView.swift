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
    @StateObject private var playerManager: PlayerRemoteManager
    @State private var tab: RoomTab = .chat
    @State private var isLandscape: Bool = false
    @State private var sheetItem: SheetItem?
    @FocusState private var isFocused: Bool
    
    init(room: RoomAttrs, currentUser: RoomMember) {
        self._viewModel = StateObject(
            wrappedValue: RoomViewModel(room: room, currentUser: currentUser)
        )
        self._playerManager = StateObject(
            wrappedValue: PlayerRemoteManager(room: room, currentUser: currentUser)
        )
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    playerView(proxy)
                        .overlay(alignment: .top) {
                            topBarView
                                .padding(.top, 44)
                        }
                    tabButtons
                }
                .overlay {
                    contextOverlay
                }
                tabViewSection
            }
        }
        .ignoresSafeArea()
        .foregroundColor(.primaryFont)
        .background(Color.primaryBg.ignoresSafeArea())
        .appAlert($viewModel.appAlert)
        .task {
            await viewModel.connectRoom()
        }
        .overlay {
            if !viewModel.status.isConnected {
                loader
            }
        }
        .sheet(item: $sheetItem) {
            makeSheet($0)
        }
        .forceRotation(orientation: [.portrait, .landscape])
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
                            sheetItem = .settings
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    } else {
                        Button {
                            sheetItem = .share
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
    
    private func playerView(_ proxy: GeometryProxy) -> some View {
        VideoPlayer(item: playerManager.currentVideo,
                    size: proxy.size,
                    isLandscape: $isLandscape,
                    setEvent: playerManager.playerEvent,
                    disabled: .init(),
                    onEvent: { playerManager.handlePlayerEvents($0) })
        .padding(.top, proxy.safeAreaInsets.top)
        .onAppear {
            if viewModel.remotePlayerDelegate == nil {
                viewModel.remotePlayerDelegate = playerManager
            }
        }
    }
    
    private var tabViewSection: some View {
        RoomTabView(tab: $tab,
                    playerManager: playerManager,
                    viewModel: viewModel,
                    chatVM: chatVM,
                    isFocused: _isFocused)
    }
    
    @ViewBuilder
    private var tabButtons: some View {
        if !isFocused {
            TabButtons(tab: $tab)
        }
    }
    
    enum SheetItem: String, Identifiable {
        case settings, share
        
        var id: String { self.rawValue }
    }
    
    enum RoomTab: String, CaseIterable {
        case chat, playlist, members
    }
    
    private var loader: some View {
        VStack {
            Text("Connecting")
            ProgressView()
                .tint(Color.primaryFont)
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 12))
        .foregroundColor(.primaryFont)
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
    
    @ViewBuilder
    private func makeSheet(_ sheet: SheetItem) -> some View {
        switch sheet {
        case .settings:
            RoomSettingsView(viewModel: viewModel)
        case .share:
            ShareSheet(code: viewModel.room.key ?? "")
                .presentationDetents([.medium])
        }
    }
}
