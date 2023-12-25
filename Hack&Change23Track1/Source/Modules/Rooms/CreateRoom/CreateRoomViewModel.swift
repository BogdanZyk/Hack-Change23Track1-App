//
//  CreateRoomViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI
import SchemaAPI

@MainActor
class CreateRoomViewModel: ObservableObject {

    @Published var template = RoomTemplate()
    @Published var appAlert: AppAlert?
    @Published var showLoader: Bool = false
    
    private var selectedTrack: PlaylistRowAttrs?
    private var createdRoom: RoomAttrs?
    private let roomService = RoomDataService()

    func createRoomWithVideo(for id: String) async {
        showLoader = true
        do {
            let room = try await createRoom()
            guard let roomId = room.id else { return }
            let tracks = try await roomService.addVideoToPlaylist(roomId: roomId, url: id)
            guard let playerItem = tracks.first else { return }
            selectedTrack = playerItem
            setTemplate(playerItem)
            createdRoom = room
            showLoader = false
        } catch {
            self.appAlert = .errors(errors: [error])
            showLoader = false
        }
    }
        
    func submitRoom() async -> RoomAttrs? {
        guard let id = selectedTrack?.id, let roomId = createdRoom?.id else { return nil }
        showLoader = true
        do {
            try await roomService.setRoomAction(for: roomId, action: .changeSource, arg: id)
            showLoader = false
            return createdRoom
        } catch {
            self.appAlert = .errors(errors: [error])
            showLoader = false
            return nil
        }
    }
    
    private func setTemplate(_ item: PlaylistRowAttrs) {
        template = .init(name: item.source.name,
                         isPrivateRoom: false,
                         image: nil,
                         imagePath: item.source.cover)
    }
    
    private func createRoom() async throws -> RoomAttrs {
        let newRoom = try await roomService.createRoom(name: template.name,
                                                       image: template.createBase64Image(),
                                                       isPrivate: template.isPrivateRoom)
        return newRoom
    }
    
    func findRoom(_ code: String) async -> RoomAttrs? {
        showLoader = true
        guard let room = try? await roomService.findRoom(code) else {
            showLoader = false
            appAlert = .basic(title: "Room not found", message: "Check the room code")
            return nil
        }
        return room
    }
}

