//
//  UserAvatarView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct UserAvatarView: View {
    var image: String?
    let userName: String
    let size: CGSize
    var withStroke: Bool = false
    var body: some View {
        ZStack {
            if let image, image.isEmpty {
                LazyNukeImage(strUrl: image)
            } else {
                Circle()
                    .fill(Color.primaryGray)
                 Text(String(userName.first ?? "A"))
                     .font(size.width > 30 ? .title3 : .subheadline)
                     .bold()
                     .foregroundColor(.primaryFont)
            }
        }
        .frame(width: size.width, height: size.height)
        .overlay {
            if withStroke {
                Circle()
                    .strokeBorder(Color.white, lineWidth: 2)
            }
        }
    }
}

struct UserAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UserAvatarView(userName: "Tester", size: .init(width: 40, height: 40), withStroke: true)
            UserAvatarView(userName: "Bob", size: .init(width: 40, height: 40), withStroke: false)
            UserAvatarView(userName: "Bob", size: .init(width: 30, height: 30), withStroke: false)
        }
    }
}
