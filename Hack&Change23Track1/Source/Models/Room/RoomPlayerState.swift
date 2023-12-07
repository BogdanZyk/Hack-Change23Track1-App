//
//  RoomPlayerState.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

struct RoomPlayerState: Codable {

    let source: Source?
    let url: String
    let status: AudioStatus
    let currentSeconds: Double
    
    enum AudioStatus: String, Codable {
        case play
        case pause
        case move
        case changeSource = "change_source"
    }
    
    var wrappedUrl: URL? {
        URL(string: url)
    }
    
    struct Source: Codable {
        let id: String
        let name: String?
        let path: String?
        let cover: String?
    }
}

