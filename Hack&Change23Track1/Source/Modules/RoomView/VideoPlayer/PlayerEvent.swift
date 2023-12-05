//
//  PlayerEvent.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 05.12.2023.
//

import Foundation

enum PlayerEvent: Identifiable, Equatable {
    
    case set(VideoItem, Double),
         play,
         pause,
         seek(Double),
         backward,
         forward,
         end
    
    var id: Int {
        switch self {
            
        case .play:
            return 0
        case .pause:
            return 1
        case .seek:
            return 2
        case .end:
            return 3
        case .set:
            return 4
        case .backward:
            return 5
        case .forward:
            return 6
        }
    }
}
