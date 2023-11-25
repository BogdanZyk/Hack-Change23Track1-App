//
//  PlaylistView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

extension AudioRoomView {
    
    struct PlaylistView: View {
        var playedId: String?
        let audios: [FileAttrs]
        let onTap: (FileAttrs) -> Void
        var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(audios) {
                        rowView($0)
                    }
                }
            }
            .padding(.top)
            .background(Color.primaryBg)
            .foregroundColor(Color.primaryFont)
        }
        
        @ViewBuilder
        private func rowView(_ audio: FileAttrs) -> some View {
            let isPlay = audio.id == playedId
            HStack {
                Text(audio.name ?? "no name")
                    .font(.headline.weight(.semibold))
                Spacer()
                if isPlay {
                    SoundWaveView(color: .primaryPink)
                        .frame(width: 28, height: 28)
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
    }
}


struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRoomView.PlaylistView(playedId: "1", audios: [.init(id: "1", name: "Audio name")], onTap: {_ in })
    }
}
