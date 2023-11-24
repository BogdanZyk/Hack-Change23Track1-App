//
//  CreateRoomView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI
import PhotosUI

struct CreateRoomView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CreateRoomViewModel()
    @State private var photoItem: PhotosPickerItem?
    let onCreate: (RoomAttrs) -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            navBarView
            titleSection
            photoPickerSection
            Spacer()
            submitButton
        }
        .padding(.horizontal)
        .background(Color.primaryBg)
        .foregroundColor(.primaryFont)
        .onChange(of: photoItem) {
            setImage($0)
        }
        .appAlert($viewModel.appAlert)
    }
    
    private var navBarView: some View {
        Text("Creating a room")
            .font(.xxLarge())
            .hCenter()
            .overlay(alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.large())
                }
            }
            .padding(.top)
    }
    
    private var titleSection: some View {
        PrimaryTextField(text: $viewModel.template.name, label: "Room name", title: "Name")
            .padding(.top)
    }
    
    private var photoPickerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Cover")
                .font(.large())
            Group {
                if let image = viewModel.template.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            Image(systemName: "trash.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    viewModel.template.image = nil
                                }
                        }
                }else {
                    PhotosPicker(selection: $photoItem) {
                        ZStack {
                            Rectangle()
                                .fill(Color.primaryGray)
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .frame(width: 100, height: 100)
            .cornerRadius(12)
        }
    }
    
    private var submitButton: some View{
        PrimaryButton(label: "Create",
                      isDisabled: viewModel.template.name.isEmpty,
                      isLoading: viewModel.showLoader) {
            Task {
                guard let newRoom = await viewModel.createRoom() else { return }
                dismiss()
                onCreate(newRoom)
            }
        }
        .padding(.bottom)
    }
    
    private func setImage(_ item: PhotosPickerItem?) {
        guard let item else { return }
        Task {
            if let data = try? await item.loadTransferable(type: Data.self) {
                viewModel.template.image = .init(data: data)
                photoItem = nil
            }
        }
    }
}
    

struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView(onCreate: {_ in })
    }
}
