//
//  RoomPlayerState.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

struct RoomPlayerState: Codable {
    
    let fileId: String
    let status: AudioStatus
    let current: Double
    let duration: Double
    let likes: Int
    
    enum AudioStatus: String, Codable {
        case play, pause, move
    }
    
}

struct AudioUIState {
    let id: String
    let total: Double
    var isPlay: Bool
    var time: Double
    var isScrubbingTime: Bool
    
    init(id: String = "",
         isPlay: Bool = false,
         time: Double = 0,
         total: Double = 0,
         isScrubbingTime: Bool = false) {
        self.id = id
        self.isPlay = isPlay
        self.time = time
        self.total = total
        self.isScrubbingTime = isScrubbingTime
    }
    
    init(from dataState: RoomPlayerState) {
        self.id = dataState.fileId
        self.isPlay = dataState.status == .play
        self.time = dataState.current
        self.total = dataState.duration
        self.isScrubbingTime = false
    }
}
