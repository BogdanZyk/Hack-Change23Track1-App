//
//  ShareUtils.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import UIKit

class ShareUtils {
        
    static func shareRoom(for code: String?) {
        guard let code else { return }
        showShareSheet(data: createInviteLink(code: code))
    }
    
    static func createInviteLink(code: String) -> String {
        "Join my music room by code: \(code)"
    }
    
    static func showShareSheet(data: Any) {
        UIActivityViewController(activityItems: [data], applicationActivities: nil).presentInKeyWindow()
    }
    
}
