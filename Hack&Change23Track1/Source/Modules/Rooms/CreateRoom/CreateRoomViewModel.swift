//
//  CreateRoomViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI

@MainActor
class CreateRoomViewModel: ObservableObject {

    @Published var template = RoomTemplate()
    @Published var appAlert: AppAlert?
    @Published var showLoader: Bool = false
    
    private var selectedSource: SourceAttrs?
    private var createdRoom: RoomAttrs?
    private let roomService = RoomDataService()

    func createRoomWithVideo(for id: String) async {
        showLoader = true
        do {
            let room = try await createRoom()
            guard let roomId = room.id else { return }
            let tracks = try await roomService.addVideoToPlaylist(roomId: roomId, url: id)
            guard let source = tracks.first?.source.fragments.sourceAttrs else { return }
            selectedSource = source
            setTemplate(source)
            createdRoom = room
            showLoader = false
        } catch {
            self.appAlert = .errors(errors: [error])
            showLoader = false
        }
    }
        
    func submitRoom() async -> RoomAttrs? {
        guard let sourceId = selectedSource?.id, let roomId = createdRoom?.id else { return nil }
        showLoader = true
        do {
            let room = try await roomService.setRoomAction(for: roomId, action: .move, arg: "")
            showLoader = false
            return createdRoom
        } catch {
            self.appAlert = .errors(errors: [error])
            showLoader = false
            return nil
        }
    }
    
    private func setTemplate(_ source: SourceAttrs) {
        template = .init(name: source.name ?? "No name",
                         isPrivateRoom: false,
                         image: nil,
                         imagePath: source.cover)
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

