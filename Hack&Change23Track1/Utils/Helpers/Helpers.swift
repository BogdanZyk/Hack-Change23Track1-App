//
//  Helpers.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import UIKit

struct Helpers {
    
    /// Return String base64 image as JPEG/PNG
    /// - Parameters:
    /// - compressionQuality: compression is 0(most)..1(least)
    static func convertImageToBase64(image: UIImage?, compressionQuality: CGFloat = 0.9) -> String? {
        guard let image = image,
              let imageData: Data = image.jpegData(compressionQuality: compressionQuality) else { return nil }
        let imageString = imageData.base64EncodedString()
        return "data:image/png;base64," + imageString
    }
    
}
