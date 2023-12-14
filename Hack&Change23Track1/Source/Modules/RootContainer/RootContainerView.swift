//
//  RootContainerView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct RootContainerView: View {
    @StateObject private var router = AppRouter()
    @StateObject private var userManager = UserManager()
    var body: some View {
        NavigationStack(path: $router.pathDestination) {
            TabView {
                RoomsView()
                    .tabItem {
                        Label("Rooms", image: "rootIcon")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", image: "persone")
                    }
            }
            .environmentObject(router)
            .environmentObject(userManager)
            .accentColor(Color.primaryPink)
            .navigationDestination(for: AppRouter.RouterDestination.self, destination: makeDestination)
        }
    }
}

struct RootContainerView_Previews: PreviewProvider {
    static var previews: some View {
        RootContainerView()
    }
}

extension RootContainerView {
    
    @ViewBuilder
    private func makeDestination(_ type: AppRouter.RouterDestination) -> some View {
        switch type {
            
        case .room(let room):
            RoomView(room: room, currentUser: userManager.getRoomMember())
                .navigationBarBackButtonHidden(true)
                .environmentObject(router)
        case .createRoom:
            CreateRoomWebView {
                self.router.setPath(to: .room($0))
            }
            .navigationBarBackButtonHidden(true)
        case .joinRoom:
            JoinInRoomView {
                self.router.setPath(to: .room($0))
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

