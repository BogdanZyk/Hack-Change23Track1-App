//
//  UserDataService.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

class UserDataService {
    
    private let api = Network.shared.client
    
    func singIn(login: String, password: String) async throws -> String {
        let mutation = SignInMutation(login: login, password: password)
        let data = try await api.mutation(mutation: mutation, publishResultToStore: false)
        guard let token = data.data?.signIn?.token else {
            throw URLError(.badServerResponse)
        }
        print("singIn with", login)
        return token
    }
    
    func singUp(login: String, password: String) async throws -> String {
        let mutation = SignUpMutation(login: login, password: password)
        let data = try await api.mutation(mutation: mutation, publishResultToStore: false)
        guard let token = data.data?.signUp?.token else {
            throw URLError(.badServerResponse)
        }
        print("singUp with", login)
        return token
    }
    
    @discardableResult
    func updateUserAvatar(avatar: String) async throws -> UserAttrs {
        let mutation = UpdateCurrentUserMutation(avatar: .init(stringLiteral: avatar))
        let data = try await api.mutation(mutation: mutation, publishResultToStore: false)
        guard let user = data.data?.updateCurrentUser?.fragments.userAttrs else {
            throw URLError(.badServerResponse)
        }
        return user
    }
    
    func getCurrentUser() async throws -> UserAttrs {
        let query = CurrentUserQuery()
        let data = try await api.fetch(query: query)
        
        guard let user = data?.data?.currentUser?.fragments.userAttrs else {
            throw URLError(.badServerResponse)
        }
        return user
    }
}
