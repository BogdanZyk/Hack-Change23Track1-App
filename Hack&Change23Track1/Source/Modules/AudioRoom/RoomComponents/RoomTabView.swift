//
//  RoomTabView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI


extension AudioRoomView {
    
    struct RoomTabView: View {
        @Binding var tab: RoomTab
        @ObservedObject var viewModel: RoomViewModel
        @ObservedObject var chatVM: RoomChatViewModel
        @FocusState var isFocused: Bool
        @State private var showAddTracksView: Bool = false
        var body: some View {
            TabView(selection: $tab) {
                makeView
                    .toolbar(.hidden, for: .tabBar)
            }
            .sheet(isPresented: $showAddTracksView) {
                AddTrackView(onSubmit: { viewModel.setPlaylist($0) })
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
                PlaylistView(showTracksLib: $showAddTracksView,
                             isOwner: viewModel.isOwner,
                             playedId: viewModel.currentAudio?.id,
                             audios: viewModel.audios,
                             onTap: viewModel.setAudio)
                .onAppear {
                    if !viewModel.isOwner {
                        viewModel.refreshRoom()
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
                ForEach(AudioRoomView.RoomTab.allCases, id: \.self) {item in
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
        AudioRoomView(room: .mock, currentUser: .mock)
    }
}
