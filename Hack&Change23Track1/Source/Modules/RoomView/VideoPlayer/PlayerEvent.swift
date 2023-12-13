//
//  PlayerEvent.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 05.12.2023.
//

import Foundation

enum PlayerEvent: Identifiable, Equatable {
    
    case set(VideoItem, Double, Bool),
         play(Double),
         pause(Double),
         seek(Double),
         backward,
         forward,
         close
    
    var id: Int {
        switch self {
            
        case .play:
            return 0
        case .pause:
            return 1
        case .seek:
            return 2
        case .set:
            return 3
        case .backward:
            return 4
        case .forward:
            return 5
        case .close:
            return 6
        }
    }
    
    var isPlay: Bool {
        switch self {
        case .play, .set:
            return true
        default:
            return false
        }
    }
}
