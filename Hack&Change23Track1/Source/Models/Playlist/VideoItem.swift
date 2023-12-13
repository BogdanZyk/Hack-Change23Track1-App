//
//  VideoItem.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 05.12.2023.
//

import Foundation
import Nuke
import SwiftUI

struct VideoItem: Identifiable, Equatable {
    let id: String
    let url: URL
    var name: String?
    var cover: String?
    
    static let mock = VideoItem(id: UUID().uuidString, url: Bundle.main.url(forResource: "video_simple", withExtension: "mp4")!, name: "Video name", cover: nil)
    
    
    func loadPreview() async -> UIImage? {
        
        guard let cover else { return nil }
        
        let request = ImageRequest(
            url: URL(string: cover),
            processors: [.resize(height: 200)],
            priority: .normal
        )
        
        
        return try? await ImagePipeline.shared.image(for: request).image
    }
    
}
//
//struct VideoItem: Identifiable {
//
//    let id: String
//    var url: URL?
//    let file: SourceAttrs
//    var status: PlaylistStatus.State = .download
//
//    mutating func setStatus(_ status: PlaylistStatus.State) {
//        self.status = status
//    }
//
//    mutating func setUrl(_ patch: String?) {
//        guard let patch, let url = URL(string: patch) else {return}
//        self.url = url
//     }
//
//    func getPlayerItem() -> PlayerItem? {
//        guard let url else { return nil }
//          return .init(id: id, url: url, cower: file.cover, name: file.name)
//    }
//
//    init(url: URL? = nil, file: SourceAttrs, status: PlaylistStatus.State) {
//        self.id = file.id ?? UUID().uuidString
//        self.url = url
//        self.file = file
//        self.status = status
//    }
//
////    init(_ media: MediaInfoAttrs) {
////        self.id = media.source?.id ?? UUID().uuidString
////        if let path = media.url, let url = URL(string: path) {
////            self.url = url
////        }
////        self.status = .ok
////        self.file = media.source?.fragments.sourceAttrs ?? .init()
////    }
//}
