//
//  AudioRoomView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct AudioRoomView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: RoomViewModel
    @State private var tab: RoomTab = .chat
    init(room: RoomAttrs, currentUser: RoomMember) {
        self._viewModel = StateObject(
            wrappedValue: RoomViewModel(room: room, currentUser: currentUser)
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            topBarView
            playerView
            tabViewSection
        }
        .foregroundColor(.primaryFont)
        .background(Color.primaryBg.ignoresSafeArea())
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
                       // viewModel.disconnect()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                .font(.title2)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
    }
    
    private var playerView: some View {
        PlayerView(isDisabledControls: !viewModel.isOwner,
                   viewModel: viewModel)
    }
    
    private var tabViewSection: some View {
        RoomTabView(tab: $tab, viewModel: viewModel)
    }
    
    enum RoomTab: String, CaseIterable {
        case chat, playlist, members
    }
    
}
