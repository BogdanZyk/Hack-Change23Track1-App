//
//  AuthView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var authManager: AuthManager
    @State var isLogin: Bool = false
    @State var pass: String = ""
    @State var login: String = ""
    @State var showLoader: Bool = false
    var body: some View {
        VStack {
            Text(isLogin ? "LogIn" : "SingUp")
                .font(.title)
            Form {
                    TextField("Login", text: $login)
                    TextField("Password", text: $pass)
                
                Group {
                    if showLoader {
                        ProgressView()
                    } else {
                        
                        Button {
                            Task {
                                showLoader = true
                                if isLogin {
                                    await authManager.signIn(login: login, pass: pass)
                                } else {
                                    await authManager.singUp(login: login, pass: pass)
                                }
                                showLoader = false
                            }
                            
                        } label: {
                            Text(isLogin ? "LogIn" : "SingUp")
                                .padding(5)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Button(isLogin ? "SingUp" : "LogIn") {
                isLogin.toggle()
            }
        }
        .appAlert($authManager.appAlert)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authManager: AuthManager())
    }
}
