//
//  CreateRoomWebView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 14.12.2023.
//

import SwiftUI

struct CreateRoomWebView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showSubmitScreen: Bool = false
    @StateObject var viewModel = CreateRoomViewModel()
    let onCreate: (RoomAttrs) -> Void
    var body: some View {
        VStack {
            Text("Select video")
                .font(.title2)
                .hCenter()
                
                .overlay(alignment: .leading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding(.horizontal)
                    }
                }
            WebNavigationView(withDismiss: false, onSelect: createRoom)
        }
        .appAlert($viewModel.appAlert)
        .overlay {
            if viewModel.showLoader {
                Color.black.opacity(0.9).ignoresSafeArea()
                VStack {
                    Text("Preparing a video")
                    ProgressView()
                }
                .foregroundColor(.white)
            }
        }
        .foregroundColor(.primaryFont)
        .navigationDestination(isPresented: $showSubmitScreen) {
            CreateRoomView(viewModel: viewModel, onCreate: onCreate)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct CreateRoomWebView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomWebView() { _ in }
    }
}

extension CreateRoomWebView {
    private func createRoom(_ videoId: String) {
        Task {
            await viewModel.createRoomWithVideo(for: videoId)
            showSubmitScreen.toggle()
        }
    }
}
