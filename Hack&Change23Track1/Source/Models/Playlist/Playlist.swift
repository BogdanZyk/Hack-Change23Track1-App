//
//  Playlist.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation

struct Playlist: Codable {
    let files: [String]
}

struct PlaylistStatus: Codable {
    
    let statuses: [AudioStatus]
    
    struct AudioStatus: Codable {
        let id: String
        let status: State
        
        enum State: String, Codable {
            case wait, error, ok, download
        }
    }
}
