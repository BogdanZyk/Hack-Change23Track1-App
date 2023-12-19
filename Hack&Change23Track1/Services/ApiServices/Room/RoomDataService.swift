//
//  RoomDataService.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import Apollo

final class RoomDataService {
    
    private let api = Network.shared.client
    
    func fetchPaginatedRooms(page: Int = 1, pageSize: Int = 20) async throws -> (rooms: [RoomAttrs], total: Int) {
        let query = GetPaginatedRoomsQuery(page: .init(integerLiteral: page), pageSize: .init(integerLiteral: pageSize))
        let data = try await api.fetch(query: query, cachePolicy: .fetchIgnoringCacheData)
        
        guard let rooms = data?.data?.getPaginatedRooms?.entries?.compactMap({$0?.fragments.roomAttrs}),
              let total = data?.data?.getPaginatedRooms?.totalPages else {
            throw URLError(.badServerResponse)
        }
        
        
        return (rooms, total)
    }
    
    func createRoom(name: String, image: String, isPrivate: Bool) async throws -> RoomAttrs {
        let mutation = CreateRoomMutation(name: name, type: .some(.case(.playlist)), image: .init(stringLiteral: image), private: .init(booleanLiteral: isPrivate))
        let data = try await api.mutation(mutation: mutation)
        guard let room = data.data?.createRoom?.fragments.roomAttrs else {
            throw URLError(.badServerResponse)
        }
        return room
    }
    
    func findRoom(_ code: String) async throws -> RoomAttrs {
        let query = GetRoomByKeyQuery(key: code)
        let data = try await api.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely)
        guard let room = data?.data?.getRoomByKey?.fragments.roomAttrs else {
            throw URLError(.badServerResponse)
        }
        return room
    }
    
    @discardableResult
    func updateRoom(for id: String, name: String, image: String, isPrivate: Bool) async throws -> RoomAttrs {
        let mutation = UpdateRoomMutation(roomId: id,
                                          name: .init(stringLiteral: name),
                                          private: .some(isPrivate),
                                          type: .some(.case(.playlist)),
                                          image: .init(stringLiteral: image))
        let data = try await api.mutation(mutation: mutation)
        guard let room = data.data?.updateRoom?.fragments.roomAttrs else {
            throw URLError(.badServerResponse)
        }
        return room
    }
    
    @discardableResult
    func removeRoom(for id: String) async throws -> String {
        let mutation = DeleteRoomMutation(roomId: id)
        let data = try await api.mutation(mutation: mutation)
           
        guard let roomId = data.data?.deleteRoom?.id else {
            throw URLError(.badServerResponse)
        }
        return roomId
    }
    
    @discardableResult
    func likeRoom(for id: String) async throws -> Int {
//        let mutation = LikeRoomMutation(roomId: id)
//        let data = try await api.mutation(mutation: mutation)
//
//        guard let likes = data.data?.likeRoom?.likes else {
//            throw URLError(.badServerResponse)
//        }
//        return likes
        0
    }
    
    func getRoomPlaylist(for id: String) async throws -> [PlaylistRowAttrs] {
        let query = GetRoomPlaylistQuery(roomId: id)
        let data = try await api.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely)
        
        guard let fileAttrs = data?.data?.getRoomPlaylist?.compactMap({$0?.fragments.playlistRowAttrs}) else {
            throw URLError(.badServerResponse)
        }
        
        return fileAttrs
    }
    
    func addVideoToPlaylist(roomId: String, url: String) async throws -> [PlaylistRowAttrs] {
        let mutation = AddPlaylistSourceMutation(roomId: roomId, url: url)
        let data = try await api.mutation(mutation: mutation)
        
        guard let fileAttrs = data.data?.addPlaylistSource?.compactMap({$0?.fragments.playlistRowAttrs}) else {
            throw URLError(.badServerResponse)
        }
        
        return fileAttrs
    }
    
    @discardableResult
    func movePlaylistItem(roomId: String, playlistRowId: String, index: Int) async throws -> [PlaylistRowAttrs] {
        let mutation = MovePlaylistSourcePositionMutation(position: index, roomId: roomId, playlistRowId: playlistRowId)
        let data = try await api.mutation(mutation: mutation)
        guard let fileAttrs = data.data?.movePlaylistSourcePosition?.compactMap({$0?.fragments.playlistRowAttrs}) else {
            throw URLError(.badServerResponse)
        }
        return fileAttrs
    }
    
    @discardableResult
    func removePlaylistItem(roomId: String, playlistRowId: String) async throws -> [PlaylistRowAttrs] {
        let mutation = DeletePlaylistSourceMutation(playlistRowId: playlistRowId, roomId: roomId)
        let data = try await api.mutation(mutation: mutation)
        
        guard let fileAttrs = data.data?.deletePlaylistSource?.compactMap({$0?.fragments.playlistRowAttrs}) else {
            throw URLError(.badServerResponse)
        }
        
        return fileAttrs
    }
    
    @discardableResult
    func setRoomAction(for roomId: String, action: RoomAction, arg: String = "") async throws -> Bool {
        let mutation = RoomActionMutation(arg: .init(stringLiteral: arg), action: .init(stringLiteral: action.rawValue), roomId: .init(stringLiteral: roomId))
        let data = try await api.mutation(mutation: mutation)

        if let error = data.errors?.first {
           throw AppError.custom(errorDescription: error.localizedDescription)
        }
        
        return data.data?.roomAction ?? false
    }
    
    func fetchStickers() async -> [String] {
//        let query = AllStickersQuery()
//        let data = try? await api.fetch(query: query)
//        guard let stickers = data?.data?.allStickers?.compactMap({$0?.stickers?.compactMap({$0})})
//            .flatMap({$0}) else { return []}
//        return stickers
        []
    }
    
    func subscribe() {
        
    }
}

enum RoomAction: String {
    case play, pause, move
}

extension RoomAttrs: Identifiable {}
extension SourceAttrs: Identifiable {}
extension PlaylistRowAttrs: Identifiable {}

extension RoomAttrs {
    
    func userIsOwner(for id: String) -> Bool {
        owner?.id == id
    }
    
    static let mock = RoomAttrs(mediaInfo: .init(currentTimeSeconds: 0, source: nil), id: "123", likes: 68, private: false, image: "", key: "00000", name: "Room name")
}
