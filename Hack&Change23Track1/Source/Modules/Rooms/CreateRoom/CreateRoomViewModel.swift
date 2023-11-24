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
    
    private let roomService = RoomDataService()
        
    func createRoom() async -> RoomAttrs? {
        showLoader = true
        do {
            let base = template.createBase64Image()
            let newRoom = try await roomService.createRoom(name: template.name,
                                                           image: template.createBase64Image(),
                                                           isPrivate: template.isPrivateRoom)
            showLoader = false
            return newRoom
        } catch {
            appAlert = .errors(errors: [error])
            showLoader = false
            return nil
        }
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


extension CreateRoomViewModel {
    
    struct RoomTemplate {
        var name: String = ""
        var isPrivateRoom: Bool = false
        var image: UIImage?
        
        
        func createBase64Image() -> String {
            Helpers.convertImageToBase64(image: image, compressionQuality: 0.9) ?? ""
        }
    }
    
}
