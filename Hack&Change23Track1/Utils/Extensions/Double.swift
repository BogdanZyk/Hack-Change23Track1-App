//
//  Double.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

extension TimeInterval {
    var minutesSecondsMilliseconds: String {
        String(format: "%02.0f:%02.0f:%02.0f",
               (self / 60).truncatingRemainder(dividingBy: 60),
               truncatingRemainder(dividingBy: 60),
               (self * 100).truncatingRemainder(dividingBy: 100).rounded(.down))
    }
    var minuteSeconds: String{
        String(format: "%02.0f:%02.0f",
               (self / 60).truncatingRemainder(dividingBy: 60),
               truncatingRemainder(dividingBy: 60))
    }
}
