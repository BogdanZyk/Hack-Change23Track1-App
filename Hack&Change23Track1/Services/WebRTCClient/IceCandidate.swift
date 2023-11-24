//
//  IceCandidate.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import WebRTC

struct IceCandidate: Codable {
    let candidate: String
    let sdpMLineIndex: Int32
    let sdpMid: String?
    
    init(from iceCandidate: RTCIceCandidate) {
        self.sdpMLineIndex = iceCandidate.sdpMLineIndex
        self.sdpMid = iceCandidate.sdpMid
        self.candidate = iceCandidate.sdp
    }
    
    var rtcIceCandidate: RTCIceCandidate {
        RTCIceCandidate(sdp: self.candidate, sdpMLineIndex: self.sdpMLineIndex, sdpMid: self.sdpMid)
    }
}
