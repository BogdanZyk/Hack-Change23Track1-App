//
//  VideoPlayer.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 04.12.2023.
//

import SwiftUI

struct VideoPlayer: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.orientation) private var orientation
    @StateObject private var manager: PlayerManager
    @State private var showPlayerControls: Bool = false
    @Binding var isLandscape: Bool
    @State private var timeoutTask: DispatchWorkItem?
    private var size: CGSize
    private var item: PlayerItem?
    private var onEvent: (PlayerEvent) -> Void
    private var setEvent: PlayerEvent
    private var disabled: Disabled
    private let viewFraction: Double = 3.5
    
    init(item: PlayerItem? = nil,
         size: CGSize,
         isLandscape: Binding<Bool>,
         setEvent: PlayerEvent,
         disabled: Disabled,
         onEvent: @escaping (PlayerEvent) -> Void) {
        self._manager = StateObject(wrappedValue: .init(item: item))
        self.size = size
        self._isLandscape = isLandscape
        self.item = item
        self.onEvent = onEvent
        self.setEvent = setEvent
        self.disabled = disabled
    }
    
    private var videoSize: CGSize {
        .init(width: size.width, height: isLandscape ? size.height : (size.height / viewFraction))
    }
    
    var body: some View {
        ZStack {
            Color.black
            if let player = manager.player {
                VideoPlayerRepresenter(player: player)
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
        .onChange(of: orientation.type) {
            isLandscape = $0.isLandscape
        }
        .forceRotation(orientation: [.landscape, .portrait])
    }
}

struct VideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayer(item: .mock, size: .init(width: 300, height: 300), isLandscape: .constant(false), setEvent: .play(0), disabled: .init(), onEvent: {_ in })
        
    }
}

extension VideoPlayer {
    
    private var playBackLayer: some View {
        Rectangle()
            .fill(.black.opacity(0.4))
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
                    manager.pause()
                    cancelTimeoutControls()
                } else {
                    manager.play()
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
                        ProgressView(value: manager.progress, total: 1)
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
            manager.seekTime()
        }
        manager.isSeek = change
    }
    
    struct Disabled {
        var disabledAllControls: Bool = false
        var disabledBackwardBtn: Bool = false
        var disabledForwardBtn: Bool = false
    }
}
