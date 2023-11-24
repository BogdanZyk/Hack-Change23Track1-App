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
        VStack {
            Text(userManager.user?.login ?? "no login user")
            Button("SignOut") {
               try? authManager.signOut()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManager())
            .environmentObject(AuthManager())
    }
}
