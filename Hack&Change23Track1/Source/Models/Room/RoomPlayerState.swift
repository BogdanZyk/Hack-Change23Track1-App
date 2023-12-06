//
//  RoomPlayerState.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

struct RoomPlayerState: Codable {

    //видео со всеми полями
    //отправляй секунды для каждого типа
    let url: String
    let status: AudioStatus
    let currentSeconds: Double
    
    enum AudioStatus: String, Codable {
        case play, pause, move, changeSource
    }
    
    var wrappedUrl: URL? {
        URL(string: url)
    }
}

