//
//  RoomMember.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

struct RoomMember: Codable, Identifiable {
    let id: String
    let login: String
    var avatar: String?
    
    static let mock = RoomMember(id: "1", login: "Mike", avatar: nil)
    
    init(id: String, login: String, avatar: String?) {
        self.id = id
        self.login = login
        self.avatar = avatar
    }
    
    init(user: UserAttrs) {
        self.login = user.login
        self.id = user.id
        self.avatar = user.avatar
    }
}
