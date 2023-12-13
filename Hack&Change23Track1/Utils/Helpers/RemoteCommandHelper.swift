//
//  RemoteCommandHelper.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import MediaPlayer

final class RemoteCommandHelper {
    
    static let shared = RemoteCommandHelper()
    
    private init() {
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.skipBackwardCommand.isEnabled = false
        commandCenter.skipForwardCommand.isEnabled = false
        commandCenter.playCommand.isEnabled = false
        commandCenter.pauseCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.stopCommand.isEnabled = false
        
        commandCenter.playCommand.addTarget { _ in .success }
    }
    
    func setupNowPlaying(_ item: VideoItem,
                         image: UIImage?,
                         currentTime: Double,
                         duration: Double) {
        
        var nowPlayingInfo = [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = item.name ?? "no name"
        
        if let image {
            let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }

        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = NSNumber(value: 1.0)
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = NSNumber(value: currentTime)
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = NSNumber(value: duration)
//        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    
        print("set RemoteCommandCenter", nowPlayingInfo)
    }
    
    func updateTime(currentTime: Double) {
        var oldPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo
        oldPlayingInfo?[MPMediaItemPropertyPlaybackDuration] = NSNumber(value: currentTime)
        MPNowPlayingInfoCenter.default().nowPlayingInfo = oldPlayingInfo
    }
    
    func removeNowPlayingItem() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
}
