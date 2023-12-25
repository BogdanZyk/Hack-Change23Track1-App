//
//  ProfileView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        VStack(spacing: 24) {
            Text("Profile")
                .font(.large(weight: .bold))
            if let user = userManager.user {
                LazyNukeImage(path: user.avatar)
                    .frame(width: 136, height: 136)
                    .clipShape(Circle())
                Group {
                    PrimaryTextField(text: .constant(user.login ?? ""), label: "Name", title: "Name")
                    PrimaryTextField(text: .constant(user.email ?? ""), label: "", title: "Email")
                }
                .disabled(true)
            } else {
                Text("Anonim user")
            }
           
            Button("SignOut") {
                try? authManager.signOut()
            }
            .foregroundColor(.red)
            .padding()
            
            Spacer()
        }
        .allFrame()
        .padding()
        .background(Color.primaryBg)
        .foregroundColor(.primaryFont)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManager())
            .environmentObject(AuthManager())
    }
}
