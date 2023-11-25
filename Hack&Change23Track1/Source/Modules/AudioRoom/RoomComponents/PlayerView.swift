//
//  PlayerView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct PlayerView: View {
    var showFullVersion: Bool = false
    var isDisabledControls: Bool = false
    @ObservedObject var viewModel: RoomViewModel
    @State private var showPlayerButton: Bool = false
    private var maxHeight: CGFloat {  getRect().height / 3.2 }
    var body: some View {
        Group {
            if showFullVersion {
                fullVersion
            } else {
                shortVersion
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PlayerView(viewModel: .init(room: .mock, currentUser: .mock))
        }
        .allFrame()
        .background(Color.primaryBg)
    }
}

extension PlayerView {
    
    
    private var fullVersion: some View {
        VStack(spacing: 0) {
            ZStack {
                // image
                //                LazyNukeImage(fullPath: viewModel.currentAudio?.file.coverFullPath, contentMode: .aspectFill, upscale: true,  crop: true)
                //
                Color.gray.opacity(0.0001)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.3)){
                            showPlayerButton.toggle()
                        }
                    }
                if !isDisabledControls {
                    playerControlsButtons
                }
            }
            timelineSectionAndInfo
        }
        .allFrame()
        .frame(height: maxHeight)
        .foregroundColor(.primaryFont)
    
    }
    
    private var shortVersion: some View {
        HStack(spacing: 12) {
            if let coverFullPath = viewModel.currentAudio?.file.coverFullPath {
                LazyNukeImage(fullPath: coverFullPath)
                    .frame(width: 40, height: 40)
                    .cornerRadius(4)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.room.name ?? "No name")
                Text(viewModel.currentAudio?.file.name ?? "No set audio")
                    .foregroundColor(.secondaryGray)
            }
            .font(.medium(weight: .medium))
            .lineLimit(2)
            Spacer()
            HStack(spacing: 18) {
                if viewModel.isOwner {
                    Image(systemName: viewModel.audioState.isPlay ? "pause.fill" : "play.fill")
                        .foregroundColor(.primaryFont)
                        .onTapGesture {
                            viewModel.togglePlay()
                        }
                    forwardBackwardButton(isForward: true)
               
                } else {
                    Image(systemName: "suit.heart.fill")
                        .font(.primary())
                        .onTapGesture {
                            viewModel.likeRoom()
                        }
                    Button {
                        ShareUtils.shareRoom(for: viewModel.room.name)
                    } label: {
                        Image(systemName: "arrowshape.turn.up.forward.fill")
                            .font(.primary())
                    }
                }
            }
            .font(.title3)
            .foregroundColor(.primaryFont)
        }
        .padding()
    }
    
    @ViewBuilder
    private var playerControlsButtons: some View {
        if showPlayerButton || !viewModel.audioState.isPlay {
            
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
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    withAnimation(.easeIn(duration: 1)) {
                        showPlayerButton = false
                    }
                }
            }
        }
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
    
    
    private var timelineSectionAndInfo: some View {

        VStack(alignment: .leading, spacing: 10) {
            VStack(spacing: 5) {
                HStack{
                    Text(viewModel.audioState.time.minuteSeconds)
                    Spacer()
                    Text(viewModel.audioState.total.minuteSeconds)
                }
                .font(.small(weight: .light))
                timeSlider
                    .tint(.white)
            }
            HStack(spacing: 16) {
                Text(viewModel.currentAudio?.file.name ?? "No select audio")
                    .lineLimit(2)
                Spacer()
                Label("\(viewModel.members.count)", systemImage: "headphones")
                likeButton
            }
            .font(.primary())
        }
        .padding()
    }
    
    @ViewBuilder
    private var timeSlider: some View {
        if isDisabledControls {
            ProgressView(value: viewModel.audioState.time, total: viewModel.audioState.total)
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
    
    private var likeButton: some View {
        HStack(spacing: 6) {
            Image(systemName: "suit.heart")
                .overlay(alignment: .bottom) {
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .modifier(ParticlesModifier(index: viewModel.roomCountLikes))
                }
            Text("\(viewModel.roomCountLikes)")
        }
        .onTapGesture {
            viewModel.likeRoom()
        }
    }
}





