//
//  VideoPlayer.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 04.12.2023.
//

import SwiftUI

struct VideoPlayer: View {
    @Environment(\.orientation) private var orientation
    @StateObject private var manager: PlayerManager
    @State private var showPlayerControls: Bool = false
    @State private var timeoutTask: DispatchWorkItem?
    private var size: CGSize
    private var item: VideoItem?
    private var onEvent: (PlayerEvent) -> Void
    private var setEvent: PlayerEvent
    private var disabled: Disabled
    private let viewFraction: Double = 3.5
    
    init(item: VideoItem? = nil,
         size: CGSize,
         setEvent: PlayerEvent,
         disabled: Disabled,
         onEvent: @escaping (PlayerEvent) -> Void) {
        self._manager = StateObject(wrappedValue: .init(item: item))
        self.size = size
        self.item = item
        self.onEvent = onEvent
        self.setEvent = setEvent
        self.disabled = disabled
    }
    
    private var videoSize: CGSize {
        .init(width: size.width, height: orientation.type.isLandscape ? size.height : (size.height / viewFraction))
    }
    
    var body: some View {
        ZStack {
            Color.black
            if let player = manager.player {
                VideoPlayerRepresenter(player: player)
                    .ignoresSafeArea()
                    .overlay {
                        playBackLayer
                        if manager.isBuffering {
                            ProgressView()
                        }
                    }
                    .overlay(alignment: .bottom) {
                        if showPlayerControls {
                            bottomSectionLayer
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            showPlayerControls.toggle()
                        }
                        if manager.isPlaying {
                            timeoutControls()
                        }
                    }
            }
        }
        .frame(width: videoSize.width, height: videoSize.height, alignment: .center)
        .onAppear {
            if manager.onEvent == nil {
                manager.onEvent = onEvent
            }
        }
        .onChange(of: setEvent) {
            manager.handlePlayerEvent($0)
        }
        .forceRotation(orientation: [.landscape, .portrait])
    }
}

struct VideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayer(item: .mock, size: .init(width: 300, height: 300), setEvent: .play(0), disabled: .init(), onEvent: {_ in })
        
    }
}

extension VideoPlayer {
    
    private var playBackLayer: some View {
        Color.black.opacity(0.4).ignoresSafeArea()
            .opacity(showPlayerControls || manager.isSeek ? 1 : 0)
            .animation(.easeIn(duration: 0.35), value: manager.isSeek)
            .overlay {
                if !disabled.disabledAllControls {
                    playBackControlsView
                }
            }
    }
    
    private var playBackControlsView: some View {
        HStack(spacing: 25) {
            Button {
                onEvent(.backward)
            } label: {
                iconLabel("backward.end.fill")
                    .disabled(disabled.disabledBackwardBtn)
                    .opacity(disabled.disabledBackwardBtn ? 0.6 : 1)
            }
            
            Button {
                if manager.isPlaying {
                    onEvent(.pause(manager.seconds.rounded()))
                    cancelTimeoutControls()
                } else {
                    onEvent(.play(manager.seconds.rounded()))
                    timeoutControls()
                }
            } label: {
                iconLabel(manager.isPlaying ? "pause.fill" : "play.fill", font: .title)
                    .scaleEffect(1.1)
            }
            
            Button {
                onEvent(.forward)
            } label: {
                iconLabel("forward.end.fill")
                    .disabled(disabled.disabledForwardBtn)
                    .opacity(disabled.disabledForwardBtn ? 0.6 : 1)
            }
        }
        .foregroundColor(.white)
        .opacity(showPlayerControls && !manager.isSeek ? 1 : 0)
        .animation(.easeIn(duration: 0.2), value: showPlayerControls && !manager.isSeek)
    }
    
    private var bottomSectionLayer: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            if let info = manager.currentItem?.name {
                Text(info)
            }
            HStack(spacing: 4) {
                Text(manager.seconds.minuteSeconds)
                Group {
                    if disabled.disabledAllControls {
                        ProgressView(value: manager.progress, total: 1.0)
                    } else {
                        Slider(value: $manager.progress, in: 0...1) { change in
                            onChangeSeek(change)
                        }
                    }
                }
                .animation(.default, value: manager.progress)
                Text(manager.totalTime.minuteSeconds)
                Button {
                    if orientation.type.isLandscape {
                        orientation.changeOrientation(to: .portrait)
                    } else {
                        orientation.changeOrientation(to: .landscape)
                    }
                } label: {
                    Image(systemName: "viewfinder")
                        .font(.body.bold())
                        .padding(10)
                }
            }
        }
        .foregroundColor(.white)
        .font(.caption)
        .padding(6)
        //            VideoSeekerView(progress: $manager.progress,
        //                            maxWidth: videoSize.width,
        //                            onChange: onChangeSeek)
        
    }
    
    
    private func iconLabel(_ icon: String, font: Font = .title3) -> some View {
        Image(systemName: icon)
            .font(font)
            .fontWeight(.ultraLight)
            .padding(15)
            .background(Material.ultraThinMaterial, in: Circle())
    }
    
    private func timeoutControls() {
        
        cancelTimeoutControls()
        
        self.timeoutTask  = .init(block: {
            withAnimation(.easeIn(duration: 0.35)) {
                showPlayerControls = false
            }
        })
        
        guard let timeoutTask else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: timeoutTask)
    }
    
    private func cancelTimeoutControls() {
        guard let timeoutTask else { return }
        timeoutTask.cancel()
    }
    
}

extension VideoPlayer {
    
    private func onChangeSeek(_ change: Bool) {
        if !change {
            onEvent(.seek(manager.seconds.rounded()))
        }
        manager.isSeek = change
    }
    
    struct Disabled {
        var disabledAllControls: Bool = false
        var disabledBackwardBtn: Bool = false
        var disabledForwardBtn: Bool = false
    }
}
