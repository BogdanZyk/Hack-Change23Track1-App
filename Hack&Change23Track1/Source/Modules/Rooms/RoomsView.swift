//
//  RoomsView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI
import SchemaAPI

struct RoomsView: View {
    @EnvironmentObject var appRouter: AppRouter
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = RoomsViewModel()
    @State private var screen: FullScreen?
    @State private var showConfirmDialog: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerSection
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.rooms) {
                        roomRow($0)
                    }
                }
            }
            .refreshable {
                fetchRooms()
            }
        }
        .padding(.horizontal)
        .background(Color.primaryBg)
        .foregroundColor(.primaryFont)
        .task {
            fetchRooms()
        }
//        .fullScreenCover(item: $screen) {
//            makeFullScreen($0)
//        }
        .confirmationDialog("", isPresented: $showConfirmDialog) {
            confirmAction
        }
        .forceRotation(orientation: .portrait)
    }
}

struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsView()
            .environmentObject(UserManager())
            .environmentObject(AppRouter())
    }
}

extension RoomsView {
    private var headerSection: some View {
    
        HStack {
            Text("Rooms")
                .font(.system(size: 32, weight: .medium))
            Spacer()
            Button {
                showConfirmDialog.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.primaryPink)
                    .padding(5)
                    .background(Color.secondaryGray.opacity(0.15), in: RoundedRectangle(cornerRadius: 8))
            }
        }
        
        .padding(.top, 8)
        .padding(.bottom)
    }
    
    private func roomRow(_ room: RoomAttrs) -> some View {
        RoomRowView(room: room)
            .onTapGesture {
                appRouter.setPath(to: .room(room))
//                screen = .room(room)
            }
    }
    
    private var confirmAction: some View {
        Group {
            Button("Create room") {
                appRouter.setPath(to: .createRoom)
            }
            Button("Join in room") {
                appRouter.setPath(to: .joinRoom)
            }
        }
    }
    
    @ViewBuilder
    private func makeFullScreen(_ screen: FullScreen) -> some View {
        switch screen {
        case .create:
            CreateRoomView { newRoom in
                self.screen = .room(newRoom)
                viewModel.setRoom(newRoom)
            }
        case .join:
            JoinInRoomView {
                self.screen = .room($0)
            }
        case .room(let room):
            RoomView(room: room, currentUser: userManager.getRoomMember())
        }
    }
    
    enum FullScreen: Identifiable {
        case create, join, room(RoomAttrs)
        
        var id: Int {
            switch self {
            case .create:
                return 0
            case .join:
                return 1
            case .room:
                return 2
            }
        }
    }
    
    private func fetchRooms() {
        Task {
            await viewModel.fetchAllRooms()
        }
    }
}

