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

    }
    
    enum State: String, Codable {
        case wait, error, ok, download
    }
}

struct VideoItem: Identifiable {
    
    let id: String
    var url: URL?
    let file: SourceAttrs
    var status: PlaylistStatus.State = .download
    
    mutating func setStatus(_ status: PlaylistStatus.State) {
        self.status = status
    }
    
    mutating func setUrl(_ patch: String?) {
        guard let patch, let url = URL(string: patch) else {return}
        self.url = url
     }
    
    init(url: URL? = nil, file: SourceAttrs, status: PlaylistStatus.State) {
        self.id = file.id ?? UUID().uuidString
        self.url = url
        self.file = file
        self.status = status
    }
    
    init(_ media: MediaInfoAttrs) {
        self.id = media.source?.id ?? UUID().uuidString
        if let path = media.url, let url = URL(string: path) {
            self.url = url
        }
        self.status = .ok
        self.file = media.source?.fragments.sourceAttrs ?? .init()
    }
}
