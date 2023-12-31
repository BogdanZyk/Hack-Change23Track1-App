//
//  Color.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI


extension Color {
    
    static let primaryBg = Color("primaryBg")
    static let primaryPink = Color("primaryPink")
    static let primaryGray = Color("primaryGray")
    static let primaryFont = Color("primaryFont")
    static let secondaryGray = Color("secondaryGray")

    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

