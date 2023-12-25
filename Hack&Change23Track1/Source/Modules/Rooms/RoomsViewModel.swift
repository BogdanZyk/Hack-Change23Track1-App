//
//  RoomsViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import SwiftUI
import SchemaAPI

@MainActor
class RoomsViewModel: ObservableObject {
    
    @Published private(set) var rooms: [RoomAttrs] = []
    
    private let roomService = RoomDataService()
    
    func fetchAllRooms() async {
        let result = try? await roomService.fetchPaginatedRooms(page: 1)
        self.rooms = result?.rooms ?? []
        print(result?.total)
    }
    
    func setRoom(_ room: RoomAttrs) {
        rooms.append(room)
    }
    
    func removeRoom(_ id: String) {
        Task {
            do {
                try await roomService.removeRoom(for: id)
                rooms.removeAll(where: {$0.id == id})
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
