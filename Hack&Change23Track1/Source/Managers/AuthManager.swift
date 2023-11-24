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
    
    func singUp(login: String, pass: String, image: String) async {
        
        do {
            let token = try await service.singUp(login: login, password: pass)
            saveJWT(token)
        } catch {
            appAlert = .errors(errors: [error])
        }
    }
    
    func signIn(login: String, pass: String) async {
        
        do {
            let token = try await service.singIn(login: login, password: pass)
            saveJWT(token)
        } catch {
            appAlert = .errors(errors: [error])
        }
    }
    
    private func saveJWT(_ token: String) {
        userDefaults.setValue(token, forKey: "JWT")
        checkIsSingIn()
    }
}


