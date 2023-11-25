//
//  PlayerView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct PlayerView: View {
    var isDisabledControls: Bool = false
    @ObservedObject var viewModel: RoomViewModel
    @State private var showPlayerButton: Bool = false
    private var maxHeight: CGFloat {  getRect().height / 3.8 }
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // image
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
                Text(viewModel.currentAudio?.name ?? "No select audio")
                    .lineLimit(1)
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





