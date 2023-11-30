//
//  FullSreenPlayer.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 30.11.2023.
//

import SwiftUI
import WebRTC

struct FullScreenPlayer: View {
   // @Environment(\.dismiss) private var dismiss
    let namespace: Namespace.ID
    @Binding var close: Bool
    var videoTrack: RTCVideoTrack?
    var body: some View {
        ZStack {
            Color.black
            if let videoTrack {
                VideoView(videoTrack: videoTrack, rotation: ._90)
                    .matchedGeometryEffect(id: "videoLayer", in: namespace)
            }
        }
        .allFrame()
        .ignoresSafeArea()
        .overlay(alignment: .bottomTrailing) {
            Button {
                withAnimation {
                    close.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct FullScreenPlayer_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenPlayer(namespace: Namespace().wrappedValue, close: .constant(false), videoTrack: nil)
    }
}


