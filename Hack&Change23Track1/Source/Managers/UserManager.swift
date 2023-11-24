//
//  UserManager.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

@MainActor
final class UserManager: ObservableObject {
        
    @Published private(set) var user: UserAttrs?
    private let userService = UserDataService()
    
    init() {
        getCurrentUser()
    }
    
    func getRoomMember() -> RoomMember {
        guard let user else {
            return .init(id: UUID().uuidString, login: "Anonim")
        }
        
        return .init(user: user)
    }
    
    private func getCurrentUser() {
        Task {
            do {
                let currentUser = try await userService.getCurrentUser()
                self.user = currentUser
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
