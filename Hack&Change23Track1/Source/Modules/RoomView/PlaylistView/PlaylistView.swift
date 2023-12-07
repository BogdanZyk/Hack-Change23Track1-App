//
//  PlaylistView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

extension RoomView {
    
    struct PlaylistView: View {
        @Binding var showTracksLib: Bool
        var isOwner: Bool
        var playedId: String?
        var videos: [SourceAttrs]
        let onTap: (SourceAttrs) -> Void
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
                            ForEach(videos) {
                                rowView($0)
                                    .contextMenu {
                                        Button("Remove", role: .destructive) {
                                            
                                        }
                                    }
                            }
                            .onMove { indexSet, offset in
                                //                            videos.move(fromOffsets: indexSet, toOffset: offset)
                                print(indexSet, offset)
                            }
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.primaryBg)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .padding(.top)
            .background(Color.primaryBg)
            .foregroundColor(Color.primaryFont)
        }
        
        @ViewBuilder
        private func rowView(_ video: SourceAttrs) -> some View {
            let isPlay = video.id == playedId
            HStack {
                LazyNukeImage(fullPath: video.cover)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                Text(video.name ?? "no name")
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
           //if isOwner {
                Button {
                    showTracksLib.toggle()
                } label: {
                    Label("Add tracks", systemImage: "plus")
                        .padding()
                }
                .foregroundColor(.primaryPink)
                .buttonStyle(.plain)
            //}
        }
    }
}


struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView.PlaylistView(showTracksLib: .constant(false),
                                   isOwner: false,
                                   playedId: "1",
                                   videos: [.init(name: "name", id: "1", cover: nil),
                                            .init(name: "name 2", id: "2", cover: nil)], onTap: {_ in })
    }
}
