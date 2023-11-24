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
        @Namespace private var namespace
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(AudioRoomView.RoomTab.allCases, id: \.self) {item in
                        Text(item.rawValue.capitalized)
                            .hCenter()
                            .padding(.vertical)
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
                TabView(selection: $tab) {
                    makeView
                }
            }
        }
        
        @ViewBuilder
        private var makeView: some View {
            switch tab {
            case.chat:
                Text("chat")
            case .members:
                MembersView(ownerId: viewModel.room.owner?.id,
                            members: viewModel.members.map({$0.value}))
            case .playlist:
                PlaylistView(playedId: viewModel.currentAudio?.id,
                             audios: viewModel.audios,
                             onTap: viewModel.setAudio)
            }
        }
    }
    
}

struct RoomTabView2_Previews: PreviewProvider {
    static var previews: some View {
        AudioRoomView(room: .mock, currentUser: .mock)
    }
}
