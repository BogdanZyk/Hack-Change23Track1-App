//
//  RoomRowView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct RoomRowView: View {
    let room: RoomAttrs
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            LazyNukeImage(path: room.image)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 3) {
                Text(room.name ?? "No name")
                    .font(.primary(weight: .medium))
                Text(room.mediaInfo?.source?.name ?? "No set track")
                    .font(.medium())
                    .fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 16) {
                    Label("\(room.likes ?? 0)", systemImage: "heart.fill")
                        .foregroundColor(Color.pink)
                    Label("\(room.members?.count ?? 0)", systemImage: "headphones")
                        .foregroundColor(Color.purple)
                }
                .padding(.top, 10)
            }
            .padding(.top, 2)
            .lineLimit(1)
        }
        .hLeading()
        .padding(.vertical, 10)
        .background(Color.primaryBg)
        .containerShape(Rectangle())
    }
}

struct RoomRowView_Previews: PreviewProvider {
    static var previews: some View {
        RoomRowView(room: .mock)
            .padding()
    }
}
