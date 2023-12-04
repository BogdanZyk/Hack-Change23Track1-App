//
//  PlayerManager.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 04.12.2023.
//

import Foundation
import AVFoundation
import SwiftUI

struct PlayerItem: Identifiable, Equatable {
    let id: String
    let url: URL
    var cower: String?
    var name: String?
    
    static let mock = PlayerItem(id: UUID().uuidString, url: Bundle.main.url(forResource: "video_simple", withExtension: "mp4")!, cower: nil, name: "Video name")
    
}

enum PlayerEvent: Identifiable, Equatable {
    case set(PlayerItem),
         play(Double),
         pause(Double),
         seek(Double),
         backward,
         forward,
         end
    
    var id: Int {
        switch self {
            
        case .play:
            return 0
        case .pause:
            return 1
        case .seek:
            return 2
        case .end:
            return 3
        case .set:
            return 4
        case .backward:
            return 5
        case .forward:
            return 6
        }
    }
}

final class PlayerManager: ObservableObject {
    
    @Published var progress: CGFloat = .zero
    @Published var isSeek: Bool = false
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var isBuffering: Bool = false
    @Published private(set) var player: AVPlayer?
    private(set) var currentItem: PlayerItem?
    
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
    
    init(item: PlayerItem?) {
        
        startScreenNotificationHandler()
        
        if let item {
            player = .init(url: item.url)
            currentItem = item
            startTimeObserver()
        }
        startSubscriptions()
        
        setupAudioSession()
    }
    
    deinit {
        removeTimeObserver()
    }
    
    private func disconnectAVPlayer() {
        toggleVideoTracks(isEnabled: false)
        lastPlayer = player
        player = nil
    }
    
    private func connectAVPlayer() {
        player = lastPlayer
        toggleVideoTracks(isEnabled: true)
    }
    
    private func toggleVideoTracks(isEnabled: Bool) {
        guard let tracks = player?.currentItem?.tracks else { return }
        for playerItemTrack in tracks {
            // Find the video tracks.
            if playerItemTrack.assetTrack?.hasMediaCharacteristic(.visual) ?? false {
                // Disable the track.
                playerItemTrack.isEnabled = isEnabled
            }
        }
    }
    
    func startScreenNotificationHandler() {
        nc.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.disconnectAVPlayer()
            }
            .store(in: cancelBag)
        nc.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.connectAVPlayer()
            }
            .store(in: cancelBag)
    }
    
    func setItemPlayer(_ item: PlayerItem) {
        if currentItem?.id == item.id { return }
        player?.pause()
        self.currentItem = item
        let playerItem = AVPlayerItem(url: item.url)
        if let player {
            player.replaceCurrentItem(with: playerItem)
        } else {
            player = .init(playerItem: playerItem)
        }
        player?.play()
        startSubscriptions()
        startTimeObserver()
        onEvent?(.set(item))
    }
    
    func play() {
        player?.play()
        onEvent?(.play(seconds))
    }
    
    func pause() {
        player?.pause()
        onEvent?(.pause(seconds))
    }
    
    func handlePlayerEvent(_ event: PlayerEvent) {
        switch event {
        case .set(let item):
            setItemPlayer(item)
        case .play(let seconds):
            seekAndPlay(seconds)
        case .pause(_):
            player?.pause()
        case .seek(let seconds):
            seekAndPlay(seconds)
        case .end:
            player?.pause()
        case .backward, .forward:
            break
        }
    }
    
    func seekAndPlay(_ time: Double) {
        player?.seek(to: .init(seconds: time, preferredTimescale: 1))
        player?.play()
    }
    
    func seekTime() {
        player?.seek(to: .init(seconds: seconds, preferredTimescale: 1)) { [weak self] completed in
            guard let self = self else {return}
            if completed {
                self.onEvent?(.seek(self.seconds))
            } else {
                self.seekTime()
            }
        }
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
            let calcProgress = currentTime / totalTime
            progress = calcProgress
            if calcProgress == 1 {
                onEvent?(.end)
            }
        }
    }
    
    private func removeTimeObserver(){
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
            cancelBag.cancel()
        }
    }
}

