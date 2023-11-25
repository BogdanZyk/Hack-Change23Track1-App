//
//  RoomTemplate.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct RoomTemplate {
    var name: String
    var isPrivateRoom: Bool
    var image: UIImage?
    var imagePath: String?
    
    func createBase64Image() -> String {
        Helpers.convertImageToBase64(image: image, compressionQuality: 0.9) ?? ""
    }
    
    init(name: String, isPrivateRoom: Bool, image: UIImage? = nil, imagePath: String? = nil) {
        self.name = name
        self.isPrivateRoom = isPrivateRoom
        self.image = image
        self.imagePath = imagePath
    }
    
    init(room: RoomAttrs) {
        self.name = room.name ?? ""
        self.isPrivateRoom = room.private ?? false
        self.imagePath = room.image
    }
    
    init() {
        self.name = ""
        self.isPrivateRoom = false
        self.image = nil
        self.imagePath = nil
    }
}
