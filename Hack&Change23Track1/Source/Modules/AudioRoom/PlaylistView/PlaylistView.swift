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
        let audios: [AudioItem]
        let onTap: (AudioItem) -> Void
        var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                if !audios.isEmpty {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        addShort
                        ForEach(audios) {
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
        private func rowView(_ audio: AudioItem) -> some View {
            let isPlay = audio.id == playedId
            HStack {
                Text(audio.file.name ?? "no name")
                    .font(.headline.weight(.semibold))
                Spacer()
                if isPlay {
                    SoundWaveView(color: .primaryPink)
                        .frame(width: 28, height: 28)
                }
                if audio.status == .download {
                    ProgressView()
                }
            }
            .hLeading()
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(isPlay ? Color.primaryGray.opacity(0.5) : Color.primaryBg)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap(audio)
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
            }
        }
        
        @ViewBuilder
        private var addShort: some View {
            if isOwner {
                Button {
                    showTracksLib.toggle()
                } label: {
                    Label("Add tracks", systemImage: "plus")
                        .padding(.vertical)
                }
                .padding(.vertical)
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
                                   audios: [.init(file: .init(name: "test"))], onTap: {_ in })
    }
}
