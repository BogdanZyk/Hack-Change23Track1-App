//
//  VideoPlayerRepresenter.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 04.12.2023.
//

import SwiftUI
import AVKit

struct VideoPlayerRepresenter: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.allowsVideoFrameAnalysis = false
        //controller.canStartPictureInPictureAutomaticallyFromInline = true
        controller.allowsPictureInPicturePlayback = false
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
    
//    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
//        let parent: AVVideoPlayer
//
//        init(_ parent: AVVideoPlayer) {
//            self.parent = parent
//        }
//
//        func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
//            parent.viewModel.pipStatus = .willStart
//        }
//
//        func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
//            parent.viewModel.pipStatus = .didStart
//        }
//
//        func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
//            parent.viewModel.pipStatus = .willStop
//        }
//
//
//        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
//            parent.viewModel.pipStatus = .didStop
//        }
//    }
}
