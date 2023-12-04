//
//  RoomPlayerState.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

struct RoomPlayerState: Codable {
    
    let fileId: String
    let url: String
    let status: AudioStatus
    let currentSeconds: Double
    
    enum AudioStatus: String, Codable {
        case play, pause, move, changeSource
    }
    
    var getPlayerEvent: PlayerEvent {
        switch status {
        case .play:
            return .play(currentSeconds)
        case .pause:
            return .pause(currentSeconds)
        case .move:
            return .seek(currentSeconds)
        case .changeSource:
            guard let url = URL(string: url) else { return .pause(currentSeconds) }
            return .set(.init(id: fileId, url: url))
        }
    }
}

