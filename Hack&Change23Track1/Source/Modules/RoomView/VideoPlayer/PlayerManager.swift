//
//  PlayerManager.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 04.12.2023.
//

import Foundation
import AVFoundation
import SwiftUI

final class PlayerManager: ObservableObject {
    
    @Published var progress: CGFloat = .zero
    @Published var isSeek: Bool = false
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var isBuffering: Bool = false
    @Published private(set) var player: AVPlayer?
    private(set) var currentItem: VideoItem?
    
    private(set) var lastPlayer: AVPlayer?
    
    var totalTime: Double {
        player?.currentItem?.duration.seconds ?? 0
    }
    
    var seconds: Double {
        totalTime * progress
    }
    
    var onEvent: ((PlayerEvent) -> Void)?
    
    private var cancelBag = CancelBag()
    private var timeObserver: Any?
    
    init(item: VideoItem?) {
        startScreenNotificationHandler()
        
        if let item {
            setItem(item)
        }
        setupAudioSession()
    }
            
    private func disconnectAVPlayer() {
        toggleVideoTracks(isEnabled: false)
        lastPlayer = player
        player = nil
    }
    
    private func connectAVPlayer() {
        guard let lastPlayer else { return }
        player = lastPlayer
        toggleVideoTracks(isEnabled: true)
        self.lastPlayer = nil
    }
    
    func startScreenNotificationHandler() {
        nc.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                guard let self = self else {return}
                print("didEnterBackgroundNotification")
                self.disconnectAVPlayer()
            }
            .store(in: cancelBag)
        nc.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                guard let self = self else {return}
                print("didBecomeActiveNotification")
                self.connectAVPlayer()
            }
            .store(in: cancelBag)
    }
    
    func setItem(_ item: VideoItem) {
        if currentItem?.id == item.id { return }
        pause()
        self.currentItem = item
        let playerItem = AVPlayerItem(url: item.url)
        if let player {
            player.replaceCurrentItem(with: playerItem)
        } else {
            player = .init(playerItem: playerItem)
        }
        player?.automaticallyWaitsToMinimizeStalling = true
        startSubscriptions()
        startTimeObserver()
    }
    
    func play() {
        player?.play()
        lastPlayer?.play()
    }
    
    func pause() {
        player?.pause()
        lastPlayer?.pause()
    }
    
    func handlePlayerEvent(_ event: PlayerEvent) {
        switch event {
        case .set(let item, let seconds):
            setItem(item)
            seekAndPlay(seconds)
        case .play(let seconds):
            seekAndPlay(seconds)
        case .pause(let seconds):
            seekAndPause(seconds)
        case .seek(let seconds):
            seekAndPlay(seconds)
        case .backward, .forward:
            break
        case .close:
            resetAll()
        }
    }
    
    func seekAndPlay(_ time: Double) {
        seek(time)
        play()
    }
    
    func seekAndPause(_ time: Double) {
        seek(time)
        pause()
    }
    
    func seek(_ time: Double) {
        let time = CMTime(seconds: time, preferredTimescale: 1000)
        player?.seek(to: time)
        lastPlayer?.seek(to: time)
    }
        
    private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .moviePlayback)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
        }
        catch {
          print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    private func startSubscriptions(){
        guard let player else { return }
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                guard let self = self else {return}
                switch status {
                case .playing:
                    self.isPlaying = true
                case .paused:
                    self.isPlaying = false
                case .waitingToPlayAtSpecifiedRate:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: cancelBag)
        
        player.currentItem?.publisher(for: \.isPlaybackLikelyToKeepUp)
            .sink{ [weak self] in
                guard let self = self else {return}
                self.isBuffering = !$0
            }
            .store(in: cancelBag)
    }
    
    private func startTimeObserver() {
        guard let player else { return }
        timeObserver = player.addPeriodicTimeObserver(forInterval: .init(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] time in
            guard let self = self else { return }
            guard !isSeek else { return }
            let currentTime = player.currentTime().seconds
            let calcProgress = min((currentTime / totalTime), totalTime)
            progress = calcProgress
        }
    }
    
    private func removeObservers(){
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
        }
        cancelBag.cancel()
    }
    
    private func toggleVideoTracks(isEnabled: Bool) {
        guard let tracks = player?.currentItem?.tracks else { return }
        Task {
            for playerItemTrack in tracks {
                // Find the video tracks.
                if let assetTrack = playerItemTrack.assetTrack {
                    let visualCharacteristics = try? await assetTrack.load(.mediaCharacteristics)
                    if visualCharacteristics?.contains(.visual) == true {
                        // Disable the track.
                        playerItemTrack.isEnabled = isEnabled
                    }
                }
            }
        }
    }
    
    private func resetAll() {
        print("reset player")
        removeObservers()
        player?.pause()
        lastPlayer?.pause()
        lastPlayer = nil
        player = nil
        currentItem = nil
        onEvent = nil
    }
}

