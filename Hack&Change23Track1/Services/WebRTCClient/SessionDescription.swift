//
//  SessionDescription.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import WebRTC

struct SessionDescription: Codable {
    let sdp: String
    let type: SdpType
    
    init(from rtcSessionDescription: RTCSessionDescription) {
        self.sdp = rtcSessionDescription.sdp
        
        switch rtcSessionDescription.type {
        case .offer:    self.type = .offer
        case .prAnswer: self.type = .prAnswer
        case .answer:   self.type = .answer
        case .rollback: self.type = .rollback
        @unknown default:
            fatalError("Unknown RTCSessionDescription type: \(rtcSessionDescription.type.rawValue)")
        }
    }

    init(from attrs: SDPClientAttrs) {
        self.sdp = attrs.sdp
        self.type = .init(rawValue: attrs.type) ?? .answer
    }

    var rtcSessionDescription: RTCSessionDescription {
        return RTCSessionDescription(type: self.type.rtcSdpType, sdp: self.sdp)
    }
    
    var serverSDPParams: SchemaAPI.ServerSDP {
        .init(type: .init(stringLiteral: type.rawValue), sdp: .init(stringLiteral: sdp))
    }
}

extension SessionDescription {
    
    enum SdpType: String, Codable {
        case offer, prAnswer, answer, rollback
        
        var rtcSdpType: RTCSdpType {
            switch self {
            case .offer:    return .offer
            case .answer:   return .answer
            case .prAnswer: return .prAnswer
            case .rollback: return .rollback
            }
        }
    }
}
