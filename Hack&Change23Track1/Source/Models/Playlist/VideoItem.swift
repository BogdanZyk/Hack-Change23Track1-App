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
        
        return try? await ImagePipeline.shared.image(for: request)
    }
    
}
