//
//  Config.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

struct Config {
    
    //static let baseURL = "http://45.12.237.146:8000"
//    static let socketURL = "ws://45.12.237.146:8000"
//
//
    static let baseURL = "http://localhost:8000"
    //static let socketURL = "ws://localhost:8000"

    
    static let turnServer = (url: "turn:45.12.237.146:3478", username: "login", credential: "password")
    
    static let defaultIceServers =
    [
        "stun:freestun.net:5350",
        "stun:stun.freestun.net:3479",
        "stun:stun.l.google.com:19302",
        "stun:stun1.l.google.com:19302",
        "stun:stun2.l.google.com:19302",
        "stun:stun3.l.google.com:19302",
        "stun:stun4.l.google.com:19302",
        "stun:stun1.voiceeclipse.net:3478",
        "stun:stun.zoiper.com:3478",
        "stun:stun.netappel.com:3478",
        "stun:stun.netappel.fr:3478"
    ]
    
}

