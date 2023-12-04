//
//  PlaylistView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

extension AudioRoomView {
    
    struct PlaylistView: View {
        @Binding var showTracksLib: Bool
        var isOwner: Bool
        var playedId: String?
        let videos: [VideoItem]
        let onTap: (VideoItem) -> Void
        var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                if !videos.isEmpty {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        addShort
                        ForEach(videos) {
                            rowView($0)
                        }
                    }
                } else {
                    addButton
                }
            }
            .allFrame()
            .padding(.top)
            .background(Color.primaryBg)
            .foregroundColor(Color.primaryFont)
        }
        
        @ViewBuilder
        private func rowView(_ video: VideoItem) -> some View {
            let isPlay = video.id == playedId
            let isLoading = video.status == .download
            HStack {
                LazyNukeImage(fullPath: video.file.coverFullPath)
                    .frame(width: 52, height: 52)
                    .cornerRadius(8)
                Text(video.file.name ?? "no name")
                    .font(.headline.weight(.semibold))
                    .padding(.trailing)
                Spacer()
                if isPlay {
                    SoundWaveView(color: .primaryPink)
                        .frame(width: 28, height: 28)
                }
                if isLoading {
                    ProgressView()
                }
            }
            .hLeading()
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(isPlay ? Color.primaryGray.opacity(0.5) : Color.primaryBg)
            .contentShape(Rectangle())
            .opacity(isLoading ? 0.6 : 1)
            .disabled(isLoading)
            .onTapGesture {
                onTap(video)
            }
        }
        
        @ViewBuilder
        private var addButton: some View {
            if isOwner {
                Button {
                    showTracksLib.toggle()
                } label: {
                    VStack {
                        Image(systemName: "plus")
                        Text("Add tracks")
                    }
                    .font(.large())
                    .foregroundColor(.primaryPink)
                }
                .padding(.top, 50)
            }
        }
        
        @ViewBuilder
        private var addShort: some View {
            if isOwner {
                Button {
                    showTracksLib.toggle()
                } label: {
                    Label("Add tracks", systemImage: "plus")
                        .padding()
                }
                .foregroundColor(.primaryPink)
            }
        }
    }
}


struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRoomView.PlaylistView(showTracksLib: .constant(false),
                                   isOwner: false,
                                   playedId: "1",
                                   videos: [.init(file: .init(name: "test"), status: .ok)], onTap: {_ in })
    }
}
