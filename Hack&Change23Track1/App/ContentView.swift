//
//  ContentView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authManager = AuthManager()
    var body: some View {
        if authManager.isSingIn {
            RootContainerView()
                .environmentObject(authManager)
        } else {
            AuthView(authManager: authManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
