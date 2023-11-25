//
//  RoomSettingsView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI
import PhotosUI

struct RoomSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: RoomViewModel
    @State private var template: RoomTemplate
    @State private var photoItem: PhotosPickerItem?
    @State private var isPresentedAlert: Bool = false
    init(viewModel: RoomViewModel) {
        self._viewModel = ObservedObject(initialValue: viewModel)
        self._template = State(initialValue: .init(room: viewModel.room))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            topBarView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24){
                    roomCode
                    roomName
                    privateToggle
                    photoPickerSection
                    Spacer()
                    removeRoomButton
                }
                .padding()
            }
        }
        .background(Color.primaryBg)
        .foregroundColor(.primaryFont)
        .onChange(of: photoItem, perform: setImage)
        .alert("Remove room?", isPresented: $isPresentedAlert) {
            alertButton
        } message: {
            Text("Do you really want to delete the room?")
        }
    }
}

struct RoomSettings_Previews: PreviewProvider {
    static var previews: some View {
        RoomSettingsView(viewModel: .init(room: .mock, currentUser: .mock))
    }
}

extension RoomSettingsView {
    
    private var topBarView: some View {
        Text("Settings")
            .font(.large(weight: .medium))
            .hCenter()
            .overlay(alignment: .leading) {
                Button {
                    dismiss()
                    if isChangeSettings {
                        viewModel.updateRoom(template)
                    }
                } label: {
                    Image(systemName: "arrow.left")
                }
            }
            .padding()
            .padding(.top, 10)
    }
    
    private var roomCode: some View {
        VStack(spacing: 10) {
            Text("Room share code")
                .font(.large())
            Text(viewModel.room.key ?? "")
                .font(.primary(weight: .bold))
                .padding()
                .background(Color.primaryGray, in: RoundedRectangle(cornerRadius: 12))
        }
        .hCenter()
    }
    
    private var roomName: some View {
        PrimaryTextField(text: $template.name, label: "Room name", title: "Name")
    }
    
    
    
    private var privateToggle: some View {
        Toggle(isOn: $template.isPrivateRoom) {
            Text("Make the room private")
                .font(.large())
        }
        .tint(Color.primaryPink)
    }
    
    private var photoPickerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Change room cover")
                .font(.large())
            PhotosPicker(selection: $photoItem, matching: .images) {
                Group {
                    if let image = template.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    }else if let imagePath = template.imagePath, !imagePath.isEmpty {
                        LazyNukeImage(path: imagePath)
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(Color.primaryGray)
                            Image(systemName: "plus")
                        }
                    }
                }
                .frame(width: 100, height: 100)
                .cornerRadius(12)
            }
        }
    }
    
    private func setImage(_ item: PhotosPickerItem?) {
        guard let item else { return }
        Task {
            if let data = try? await item.loadTransferable(type: Data.self) {
                template.image = .init(data: data)
                photoItem = nil
            }
        }
    }
    
    private var removeRoomButton: some View {
        Button {
            isPresentedAlert.toggle()
        } label: {
            Label("Delete room :(", systemImage: "trash")
                .font(.medium())
                .foregroundColor(.red)
        }
        .hCenter()
    }
    
    private var isChangeSettings: Bool {
        template.image != nil || template.name != viewModel.room.name || template.isPrivateRoom != viewModel.room.private
    }
    
    private var alertButton: some View {
        Button("Yes", role: .destructive) {
            dismiss()
        }
    }
    
}
