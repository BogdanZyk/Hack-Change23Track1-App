//
//  PlaylistView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI
import SchemaAPI

extension RoomView {
    
    struct PlaylistView: View {
        @Binding var showTracksLib: Bool
        var showLoader: Bool
        var isOwner: Bool
        var playedId: String?
        @Binding var videos: [PlaylistRowAttrs]
        let onTap: (String) -> Void
        let onRemove: (String) -> Void
        let onMove: (String, Int) -> Void
        var body: some View {
            
            Group {
                if videos.isEmpty {
                    ZStack {
                        addButton
                    }
                    .allFrame()
                } else {
                    List {
                        Group {
                            addShort
                            ForEach(videos) { video in
                                rowView(video)
                            }
                            .onMove { indexSet, offset in
                                videos.move(fromOffsets: indexSet, toOffset: offset)
                                guard let id = videos[s: offset]?.id else { return }
                                onMove(id, offset)
                            }
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.primaryBg)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .disabled(!isOwner)
                }
            }
            .padding(.top)
            .background(Color.primaryBg)
            .foregroundColor(Color.primaryFont)
            .overlay {
                if showLoader {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(Color.primaryPink)
                }
            }
        }
        
        @ViewBuilder
        private func rowView(_ video: PlaylistRowAttrs) -> some View {
            let isPlay = video.id == playedId
            HStack {
                LazyNukeImage(fullPath: video.source?.cover, resizeSize: .init(width: 40, height: 40), contentMode: .aspectFit)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                Text(video.source?.name ?? "")
                    .font(.headline.weight(.semibold))
                    .padding(.trailing)
                    .lineLimit(2)
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
                guard let id = video.id else {return}
                onTap(id)
            }
            .contextMenu {
                if !isPlay {
                    Button("Remove", role: .destructive) {
                        onRemove(video.id ?? "")
                        videos.removeAll(where: {$0.id == video.id})
                    }
                }
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
                .buttonStyle(.plain)
            }
        }
    }
}


struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView.PlaylistView(showTracksLib: .constant(false),
                              showLoader: false,
                              isOwner: false,
                              playedId: "1",
                              videos: .constant([]),
                              onTap: {_ in },
                              onRemove: {_ in},
                              onMove: {_, _ in})
    }
}
