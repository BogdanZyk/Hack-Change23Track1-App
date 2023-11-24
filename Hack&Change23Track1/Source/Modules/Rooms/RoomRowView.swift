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
        HStack(alignment: .top, spacing: 16) {
            LazyNukeImage(strUrl: room.image)
                .frame(width: 96, height: 96)
                .cornerRadius(12)
            VStack(alignment: .leading, spacing: 2) {
                Text(room.name ?? "No name")
                    .font(.large(weight: .medium))
                Text(room.file?.file?.name ?? "No set track")
                    .font(.primary())
                HStack(spacing: 16) {
                    Label("\(room.likes ?? 0)", systemImage: "heart")
                        .foregroundColor(Color.pink)
                    Label("\(room.members?.count ?? 0)", systemImage: "headphones")
                        .foregroundColor(Color.purple)
                }
                .padding(.top, 14)
            }
            .lineLimit(1)
            .padding(.top, 4)
        }
        .hLeading()
    }
}

struct RoomRowView_Previews: PreviewProvider {
    static var previews: some View {
        RoomRowView(room: .mock)
            .padding()
    }
}
