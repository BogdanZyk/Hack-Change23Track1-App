//
//  FullSreenPlayer.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 30.11.2023.
//

import SwiftUI
import WebRTC

struct FullScreenPlayer: View {
    let namespace: Namespace.ID
    @Binding var close: Bool
    @ObservedObject var viewModel: RoomViewModel
    var body: some View {
        PlayerView2(namespace: namespace,
                    isLandscapeOrientation: true,
                    showFullScreen: $close,
                    viewModel: viewModel)
        .ignoresSafeArea()
    }
}

struct FullScreenPlayer_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenPlayer(namespace: Namespace().wrappedValue, close: .constant(false), viewModel: .init(room: .mock, currentUser: .mock))
    }
}


