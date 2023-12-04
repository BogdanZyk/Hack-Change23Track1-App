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
    
    func fetchRooms() async throws -> [RoomAttrs] {
        let query = ListRoomsQuery()
        let data = try await api.fetch(query: query, cachePolicy: .fetchIgnoringCacheData)
        
        guard let rooms = data?.data?.listRooms?.compactMap({$0?.fragments.roomAttrs}) else {
            throw URLError(.badServerResponse)
        }
        
        return rooms
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
        let mutation = UpdateRoomMutation(roomId: id, image: .init(stringLiteral: image), private: .some(isPrivate), type: .some(.case(.playlist)), name: .init(stringLiteral: name))
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
        let mutation = LikeRoomMutation(roomId: id)
        let data = try await api.mutation(mutation: mutation)
        
        guard let likes = data.data?.likeRoom?.likes else {
            throw URLError(.badServerResponse)
        }
        return likes
    }
    
    func fetchAudios() async throws -> [SourceAttrs] {
        let query = ListSourcesQuery()
        let data = try await api.fetch(query: query)
        
        guard let fileAttrs = data?.data?.listSources?.compactMap({$0?.fragments.sourceAttrs}) else {
            throw URLError(.badServerResponse)
        }
        
        return fileAttrs
    }
    
    func initConnection(for roomId: String, offer: SessionDescription) async throws -> SessionDescription {
        let mutation = InitConnectionMutation(sdp: offer.serverSDPParams, roomId: roomId)
        let data = try await api.mutation(mutation: mutation, publishResultToStore: false)
       
        guard let sDPClientAttrs = data.data?.initConnection?.fragments.sDPClientAttrs else {
            throw AppError.custom(errorDescription: "Empty sDPClientAttrs")
        }
        
        return .init(from: sDPClientAttrs)
    }
    
    @discardableResult
    func loadVideo(for roomId: String, sourceId: String) async throws -> RoomAttrs {
        
        let mutation = LoadMediaMutation(sourceId: sourceId, roomId: roomId)
        
        let data = try await api.mutation(mutation: mutation)
        
        guard let room = data.data?.loadMedia?.fragments.roomAttrs else {
            throw URLError(.badServerResponse)
        }
        
        return room
    }
    
    @discardableResult
    func setRoomAction(for roomId: String, action: RoomAction, arg: String = "") async throws -> Bool {
        let mutation = RoomActionMutation(roomId: roomId, action: action.rawValue, arg: arg)
        let data = try await api.mutation(mutation: mutation)
        return data.data?.roomAction?.fragments.roomAttrs != nil
    }
    
    func fetchStickers() async -> [String] {
        let query = AllStickersQuery()
        let data = try? await api.fetch(query: query)
        guard let stickers = data?.data?.allStickers?.compactMap({$0?.stickers?.compactMap({$0})})
            .flatMap({$0}) else { return []}
        return stickers
    }
}

enum RoomAction: String {
    case play, pause, move
}

extension RoomAttrs: Identifiable {}
extension SourceAttrs: Identifiable {
    
    var coverFullPath: String {
        "http://45.12.237.146" + (cover ?? "")
    }
    
}


extension RoomAttrs {
    
    func userIsOwner(for id: String) -> Bool {
        owner?.id == id
    }
    
    static let mock = RoomAttrs(mediaInfo: .init(currentSeconds: "0", pause: false, source: nil, url: ""), id: "123", likes: 68, private: false, image: "", key: "00000", name: "Room name", members: [.init(id: "1", login: "test", avatar: "", email: "email@test.com")])
}
