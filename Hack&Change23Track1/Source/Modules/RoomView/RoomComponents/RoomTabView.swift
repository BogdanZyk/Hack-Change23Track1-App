//
//  RoomTabView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI


extension RoomView {
    
    struct RoomTabView: View {
        @Binding var tab: RoomTab
        @ObservedObject var playerManager: PlayerRemoteManager
        @ObservedObject var viewModel: RoomViewModel
        @ObservedObject var chatVM: RoomChatViewModel
        @FocusState var isFocused: Bool
        @State private var showWebView: Bool = false
        var body: some View {
            TabView(selection: $tab) {
                makeView
                    .toolbar(.hidden, for: .tabBar)
            }
            .sheet(isPresented: $showWebView) {
                WebNavigationView(onSelect: { playerManager.addNewVideoItemAndSetToPlay($0) })
            }
        }
                
        @ViewBuilder
        private var makeView: some View {
            switch tab {
            case.chat:
                RoomChatView(isFocused: _isFocused,
                             roomVM: viewModel,
                             chatVM: chatVM)
            case .members:
                MembersView(ownerId: viewModel.room.owner?.id,
                            members: viewModel.members.map({$0.value}))
            case .playlist:
                PlaylistView(showTracksLib: $showWebView,
                             showLoader: playerManager.itemLoader == .addingPlaylist,
                             isOwner: viewModel.isOwner,
                             playedId: playerManager.currentVideo?.id,
                             videos: $playerManager.playList,
                             onTap: { playerManager.setSource($0.id) },
                             onRemove: { playerManager.removeSource(for: $0) },
                             onMove: { playerManager.moveSource(for: $0, to: $1) })
                .appAlert($playerManager.appAlert)
                .onAppear {
                    if !viewModel.isOwner {
                        playerManager.fetchPlaylist()
                    }
                }
            }
        }
    }
    
    struct TabButtons: View {
        @Namespace private var namespace
        @Binding var tab: RoomTab
        var body: some View {
            HStack(spacing: 0) {
                ForEach(RoomView.RoomTab.allCases, id: \.self) {item in
                    Text(item.rawValue.capitalized)
                        .hCenter()
                        .padding(.vertical, 10)
                        .overlay(alignment: .bottom) {
                            if tab == item {
                                Rectangle()
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "roomTab", in: namespace)
                            }
                        }
                        .foregroundColor(tab == item ? .primaryPink : .primaryFont)
                        .animation(.default, value: tab)
                        .containerShape(Rectangle())
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            tab = item
                        }
                }
            }
        }
    }
    
}

struct RoomTabView2_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(room: .mock, currentUser: .mock)
    }
}
