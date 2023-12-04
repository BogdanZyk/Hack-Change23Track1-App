//
//  PlayerView2.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 30.11.2023.
//

import SwiftUI
import AVKit

struct PlayerView2: View {
    let namespace: Namespace.ID
    var isLandscapeOrientation: Bool = false
    @Binding var showFullScreen: Bool
    var isDisabledControls: Bool = false
    @ObservedObject var viewModel: RoomViewModel
    @State var player: AVPlayer?
    @State private var showPlayerControlsBtn: Bool = false
    var body: some View {
        ZStack {
            playerLayerView
//            if showPlayerControlsBtn || !viewModel.audioState.isPlay {
//                controlsLayerView
//            }
        }
        .foregroundColor(.white)
        .onAppear {
            if let path = viewModel.room.mediaInfo?.url, let url = URL(string: path) {
                print(url.absoluteString)
                player = .init(url: url)
            }
        }
    }
}

struct PlayerView2_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView2(namespace: Namespace().wrappedValue, showFullScreen: .constant(false), viewModel: .init(room: .mock, currentUser: .mock))
    }
}

extension PlayerView2 {
    
    private var playerLayerView: some View {
        ZStack {
            Color.black
            if let player {
                VideoPlayer(player: player)
            }
             
//            VideoView(videoTrack: viewModel.remoteVideoTrack, rotation: isLandscapeOrientation ? ._90 : ._0)
//                .matchedGeometryEffect(id: "videoLayer", in: namespace)
        }
//        .onTapGesture {
//            withAnimation(.easeIn(duration: 0.3)){
//                showPlayerControlsBtn.toggle()
//            }
//        }
    }
    
    private var controlsLayerView: some View {
        ZStack {
            
            if !isDisabledControls {
                playControlsButton
            }
            bottomControlsSection
                .vBottom()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                withAnimation(.easeIn(duration: 1)) {
                    showPlayerControlsBtn = false
                }
            }
        }
    }
    
    private var playControlsButton: some View {
        playButtons
    }
    
    private var bottomControlsSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Video name and video info")
                .font(.small())
            HStack(spacing: 8) {
                Text(viewModel.audioState.time.minuteSeconds)
                timeSlider
                Text(viewModel.audioState.total.minuteSeconds)
                Button {
                    withAnimation {
                        showFullScreen.toggle()
                    }
                  
                } label: {
                    Image(systemName: "viewfinder")
                        .font(.body.bold())
                }
            }
            .font(.small(weight: .light))
        }
        .padding(8)
    }
    
    private var timeSlider: some View {
        Group{
            if isDisabledControls {
                ProgressView(value: 10, total: 100)
                    .hCenter()
            } else {
                Slider(value: $viewModel.audioState.time, in: 0...viewModel.audioState.total) { change in
                    viewModel.audioState.isScrubbingTime = change
                    if !change {
                        viewModel.moveAudioTime()
                    }
                }
            }
        }
        .tint(Color.primaryPink)
    }
    
    
    private var playButtons: some View {
        HStack(spacing: 20) {
            forwardBackwardButton(isForward: false)
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Material.ultraThinMaterial)
                    .frame(width: 60, height: 60)
                Image(systemName: viewModel.audioState.isPlay ? "pause.fill" : "play.fill")
                    .foregroundColor(.primaryFont)
            }
            .onTapGesture {
                viewModel.togglePlay()
            }
            forwardBackwardButton(isForward: true)
        }
        .font(.title)
    }
    
    @ViewBuilder
    private func forwardBackwardButton(isForward: Bool ) -> some View {
        let isDisabled = isForward ? viewModel.isDisabledNext : viewModel.isDisabledPreviews
        Image(systemName: isForward ? "forward.fill" : "backward.fill")
            .opacity(isDisabled ? 0.5 : 1)
            .onTapGesture {
                if isForward {
                    viewModel.startNextAudio()
                } else {
                    viewModel.startPreviewsAudio()
                }
            }
            .disabled(isDisabled)
    }
    
}
