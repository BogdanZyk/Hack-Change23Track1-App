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
    private var maxHeight: CGFloat {  getRect().height / 3 }
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
            PlayerView(showFullVersion: true, viewModel: .init(room: .mock, currentUser: .mock))
        }
        .allFrame()
        .background(Color.primaryBg)
    }
}

extension PlayerView {
    
    private var fullVersion: some View {
        
        ZStack {
            if let image = viewModel.currentAudio?.file.coverFullPath, !image.isEmpty {
                LazyNukeImage(fullPath: image,
                              contentMode: .aspectFit,
                              loadColor: .primaryBg)
                    .frame(maxHeight: maxHeight)
            }
            LinearGradient(colors: [Color.primaryBg, Color.primaryBg.opacity(0.5), .clear], startPoint: .bottom, endPoint: .top)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.3)){
                        showPlayerButton.toggle()
                    }
                }
            timelineSectionAndInfo
                .vBottom()
            if !isDisabledControls {
                playerControlsButtons
                    .padding(.bottom, maxHeight / 3.5)
            }
        }
        .allFrame()
        .frame(height: maxHeight)
        .foregroundColor(.primaryFont)
    }
    
    private var shortVersion: some View {
        HStack(spacing: 12) {
            if let coverFullPath = viewModel.currentAudio?.file.coverFullPath {
                LazyNukeImage(fullPath: coverFullPath)
                    .frame(width: 60, height: 60)
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
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                Spacer()
                Label("\(viewModel.members.count)", systemImage: "headphones")
                likeButton
            }
            .font(.primary())
        }
        .padding()
    }
    
    private var timeSlider: some View {
        Group{
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
        .tint(Color.primaryPink)
    }
    
    private var likeButton: some View {
        HStack(spacing: 6) {
            Image(systemName: "suit.heart.fill")
                .foregroundColor(.primaryPink)
                .overlay(alignment: .bottom) {
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .foregroundColor(.primaryPink)
                        .modifier(ParticlesModifier(index: viewModel.roomCountLikes))
                }
            Text("\(viewModel.roomCountLikes)")
        }
        .onTapGesture {
            viewModel.likeRoom()
        }
    }
}
