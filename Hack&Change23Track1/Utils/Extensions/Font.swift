//
//  Font.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

extension Font {
    
    /// SF Pro size 12
    static func xSmall(weight: Weight?=nil) -> Font {
        .system(size: 12, weight: weight)
    }
    
    /// SF Pro size 14
    static func small(weight: Weight?=nil) -> Font {
        .system(size: 14, weight: weight)
    }
    
    /// SF Pro size 16
    static func medium(weight: Weight?=nil) -> Font {
        .system(size: 16, weight: weight)
    }
    
    /// SF Pro size 18
    static func primary(weight: Weight?=nil) -> Font {
        .system(size: 18, weight: weight)
    }
    
    /// SF Pro size 20
    static func large(weight: Weight?=nil) -> Font {
        .system(size: 20, weight: weight)
    }
    
    /// SF Pro size 22
    static func xLarge(weight: Weight?=nil) -> Font {
        .system(size: 22, weight: weight)
    }
    
    /// SF Pro size 24
    static func xxLarge(weight: Weight?=nil) -> Font {
        .system(size: 24, weight: weight)
    }
    
    /// SF Pro size 34
    static func primaryTitle(weight: Weight?=nil) -> Font {
        .system(size: 34, weight: weight)
    }
    
    /// SF Pro size 44
    static func xxxLarge(weight: Weight?=nil) -> Font {
        .system(size: 44, weight: weight)
    }
}
