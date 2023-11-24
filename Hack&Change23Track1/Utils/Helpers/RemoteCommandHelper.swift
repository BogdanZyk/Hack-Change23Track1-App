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
    
    func setupNowPlaying(_ item: MediaItem) {
        
        print("set RemoteCommandCenter")

        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
        let image = item.image ?? UIImage()
        let artwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: {  (_) -> UIImage in
          return image
        })

        nowPlayingInfo[MPMediaItemPropertyTitle] = item.title
        
        if let album = item.album {
            nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = album
        }
        nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = NSNumber(value: 1.0)
        
//        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = NSNumber(value: 0)
//        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = NSNumber(value: 300)
//
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
    func removeNowPlayingItem() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
    
    struct MediaItem {
        let title: String
        var album: String?
        var image: UIImage?
    }
}
