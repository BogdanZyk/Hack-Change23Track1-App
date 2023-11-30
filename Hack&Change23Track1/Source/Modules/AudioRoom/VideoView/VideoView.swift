//
//  VideoView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 29.11.2023.
//

import SwiftUI
import WebRTC

struct VideoView: UIViewRepresentable {
    
    var videoTrack: RTCVideoTrack?
    var rotation: RTCVideoRotation = ._0
    @State var currentVideoTrackId: String?
    
    func makeUIView(context: Context) -> RTCMTLVideoView {
        let view = RTCMTLVideoView(frame: .zero)
        view.rotationOverride = NSNumber(value: rotation.rawValue)
        view.videoContentMode = .scaleAspectFit
        return view
    }

    func updateUIView(_ view: RTCMTLVideoView, context: Context) {
        if videoTrack != nil, currentVideoTrackId != videoTrack?.trackId  {
            print("Set video track in player view", videoTrack?.trackId)
            DispatchQueue.main.async {
                currentVideoTrackId = videoTrack?.trackId
            }
            videoTrack?.add(view)
        }
    }
}
