//
//  RoomView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI
import SchemaAPI

struct RoomView: View {
    @EnvironmentObject var appRouter: AppRouter
    @StateObject private var orientation = OrientationManager()
    @StateObject private var chatVM = RoomChatViewModel()
    @StateObject private var viewModel: RoomViewModel
    @StateObject private var playerManager: PlayerRemoteManager
    @State private var tab: RoomTab = .chat
    @State private var sheetItem: SheetItem?
    @State private var showChatForLandscape: Bool = false
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
        
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                topBarView
                HStack(spacing: 0) {
                    playerView
                    chatLandscape
                        .transition(.move(edge: .trailing))
                }
                .animation(.default, value: showChatForLandscape)
                tabButtons
            }
            .overlay {
                contextOverlay
            }
            if !orientation.type.isLandscape {
                tabViewSection
            }
        }
        
        .foregroundColor(.primaryFont)
        .background(Color.primaryBg.ignoresSafeArea())
        .appAlert($viewModel.appAlert)
        .task {
            viewModel.connectRoom()
            if viewModel.chatDelegate == nil {
                viewModel.chatDelegate = chatVM
            }
        }
        .overlay {
            if viewModel.state == .connecting {
                loader
            }
        }
        .sheet(item: $sheetItem) {
            makeSheet($0)
        }
        .forceRotation(orientation: [.portrait, .landscape])
        .alert("Leave the room?", isPresented: $viewModel.isPresentedLeaveAlert) { alertButton }
    }
}

struct AudioRoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(room: .mock, currentUser: .mock)
            .environmentObject(AppRouter())
    }
}

extension RoomView {
    
    @ViewBuilder
    private var topBarView: some View {
        if !orientation.type.isLandscape {
            Text(viewModel.room.name ?? "no key")
                .font(.primary())
                .hCenter()
                .lineLimit(1)
                .overlay {
                    HStack {
                        Button {
                            viewModel.isPresentedLeaveAlert.toggle()
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
    }
    
    private var playerView: some View {
        VideoPlayer(item: nil,
                    orientation: orientation,
                    setEvent: playerManager.playerEvent,
                    disabled: .init(disabledAllControls: playerManager.isDisableControls,
                                    disabledBackwardBtn: playerManager.isDisabledPreviews, disabledForwardBtn: playerManager.isDisabledNext),
                    onEvent: { playerManager.handlePlayerEvents($0) })
        .overlay(alignment: .top) {
            if orientation.type.isLandscape {
                Button {
                    showChatForLandscape.toggle()
                    isFocused = false
                } label: {
                    Image(systemName: "text.bubble")
                        .foregroundColor(.white)
                        .padding()
                }
                .hTrailing()
            }
        }
        .overlay {
            if playerManager.itemLoader == .setSource {
                Color.black.opacity(0.3)
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(Color.primaryPink)
            }
        }
    }
    
    @ViewBuilder
    private var chatLandscape: some View {
        if orientation.type.isLandscape && showChatForLandscape {
            RoomChatView(isFocused: _isFocused,
                         roomVM: viewModel,
                         chatVM: chatVM)
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
        if !orientation.type.isLandscape {
            if !isFocused {
                TabButtons(tab: $tab)
            }
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
        if chatVM.selectedMessage != nil && !orientation.type.isLandscape  {
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
    
    private var alertButton: some View {
        Button("Yes", role: .destructive) {
            viewModel.disconnectAll()
            playerManager.closePlayer()
            orientation.changeOrientation(to: .portrait)
            isFocused = false
            appRouter.popToRoot()
        }
    }
}
