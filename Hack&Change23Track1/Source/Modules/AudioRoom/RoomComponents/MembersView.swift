//
//  MembersView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

extension AudioRoomView {
    struct MembersView: View {
        var ownerId: String?
        let members: [RoomMember]
        var body: some View {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(members) {
                        rowView($0)
                            
                    }
                }
                .padding(.top)
            }
            .padding()
            .foregroundColor(.primaryFont)
            .background(Color.primaryBg)
        }
        
        private func rowView(_ member: RoomMember) -> some View {
            HStack(spacing: 15) {
                UserAvatarView(image: member.avatar,
                               userName: member.login,
                               size: .init(width: 45, height: 45),
                               withStroke: false)
                Text(member.login)
                    .font(.primary(weight: .semibold))
                Spacer()
                if ownerId == member.id {
                    Text("owner")
                        .foregroundColor(.primaryPink)
                }
            }
        }
    }
}


struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRoomView.MembersView(ownerId: "", members: [.mock])
    }
}
