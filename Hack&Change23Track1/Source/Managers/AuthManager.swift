//
//  AuthManager.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

@MainActor
final class AuthManager: ObservableObject {
    
    @Published private(set) var isSingIn: Bool = false
    
    @Published var appAlert: AppAlert?
    
    private let userDefaults = UserDefaults.standard
    private let service = UserDataService()
    
    init() {
        checkIsSingIn()
    }
    
    func checkIsSingIn() {
        isSingIn = userDefaults.string(forKey: "JWT") != nil
    }
    
    func signOut() throws {
        userDefaults.removeObject(forKey: "JWT")
        isSingIn = false
    }
    
    func singUp(email: String, pass: String, image: String, login: String) async {
        
        do {
            let token = try await service.singUp(email: email.noSpaceStr.lowercased(),
                                                 password: pass.noSpaceStr, login: login)
            saveJWT(token)
            try? await updateUserAvatar(image)
        } catch {
            appAlert = .errors(errors: [error])
        }
    }
    
    func signIn(email: String, pass: String) async {
        
        do {
            let token = try await service.singIn(email: email.noSpaceStr.lowercased(),
                                                 password: pass)
            saveJWT(token)
        } catch {
            appAlert = .errors(errors: [error])
        }
    }
    
    func updateUserAvatar(_ image: String?) async throws {
        guard let image else { return }
        try await service.updateUserAvatar(avatar: image)
    }
    
    private func saveJWT(_ token: String) {
        userDefaults.setValue(token, forKey: "JWT")
        checkIsSingIn()
        Network.shared.createSplitClientIfNeeded()
    }
}


