//
//  AuthView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI
import PhotosUI

struct AuthView: View {
    @ObservedObject var authManager: AuthManager
    @State private var item: PhotosPickerItem?
    @State private var image: UIImage?
    @State private var isLogin: Bool = false
    @State private var email: String = ""
    @State private var pass: String = ""
    @State private var login: String = ""
    @State private var showLoader: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            formSection
            Spacer()
            submitSection
        }
        .allFrame()
        .padding()
        .foregroundColor(.primaryFont)
        .background(Color.primaryBg.ignoresSafeArea())
        .appAlert($authManager.appAlert)
        .onChange(of: item, perform: setImage)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authManager: AuthManager())
    }
}

extension AuthView {
    
    private var title: some View {
        Text(isLogin ? "Log In" : "Create an account")
            .font(.xxLarge(weight: .medium))
            .hCenter()
    }
    
    private var formSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            title
                .padding(.bottom)
            if !isLogin {
                avatarPicker
                PrimaryTextField(text: $login, label: "Name", title: nil, isSecure: false)
            }
            VStack(alignment: .leading, spacing: 2) {
                if !email.isEmpty && !email.isEmail {
                    Text("Enter a valid emeil")
                        .font(.small())
                        .foregroundColor(.red)
                }
                PrimaryTextField(text: $email, label: "Email", title: nil, isSecure: false)
            }
            PrimaryTextField(text: $pass, label: "Password", title: nil, isSecure: true)
        }
    }
    
    private var submitSection: some View {
        VStack {
            HStack {
                Text(isLogin ? "No account?" : "Have an account?")
                Button(isLogin ? "Sign Up" : "Log In") {
                    isLogin.toggle()
                }
                .foregroundColor(.blue)
            }
            PrimaryButton(label: isLogin ? "LogIn" : "Create an Account",
                          isDisabled: !isValid(),
                          isLoading: showLoader,
                          action: submit)
        }
        .padding(.bottom)
    }
    
    private var avatarPicker: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .overlay {
                        Image(systemName: "trash.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .onTapGesture {
                                self.image = nil
                            }
                    }
            }else {
                PhotosPicker(selection: $item) {
                    ZStack {
                        Rectangle()
                            .fill(Color.primaryGray)
                        Image(systemName: "person")
                            .font(.largeTitle)
                            .foregroundColor(.secondaryGray)
                    }
                }
            }
        }
        .frame(width: 130, height: 130)
        .clipShape(Circle())
        .hCenter()
        .padding(.bottom)
    }
    
    private func setImage(_ item: PhotosPickerItem?) {
        guard let item else { return }
        Task {
            if let data = try? await item.loadTransferable(type: Data.self) {
                self.image = .init(data: data)
                self.item = nil
            }
        }
    }
    
    private func isValid() -> Bool {
        if isLogin {
            return !pass.isEmpty && email.isEmail
        } else {
            return pass.count > 3 && !login.isEmpty && email.isEmail
        }
    }
    
    private func submit() {
        
        Task {
            showLoader = true
            if isLogin {
                await authManager.signIn(email: login, pass: pass)
            } else {
                let image = Helpers.convertImageToBase64(image: image, compressionQuality: 0.9)
                await authManager.singUp(email: email,
                                         pass: pass,
                                         image: image ?? "",
                                         login: login)
            }
            showLoader = false
        }
    }

}
