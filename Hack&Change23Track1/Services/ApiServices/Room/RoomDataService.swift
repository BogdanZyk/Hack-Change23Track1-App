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
        let mutation = CreateRoomMutation(name: name, image: .init(stringLiteral: image), private: .init(booleanLiteral: isPrivate))
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
    
    func fetchAudios() async throws -> [FileAttrs] {
        let query = ListAudioQuery()
        let data = try await api.fetch(query: query)
        
        guard let fileAttrs = data?.data?.listAudio?.compactMap({$0?.fragments.fileAttrs}) else {
            throw URLError(.badServerResponse)
        }
        
        return fileAttrs
    }
    
    func initConnection(for roomId: String, offer: SessionDescription) async throws -> SessionDescription {
        let mutation = InitConnectionMutation(sdp: offer.serverSDPParams, roomId: roomId)
        let data = try await api.mutation(mutation: mutation, publishResultToStore: false)
        
        guard let sDPClientAttrs = data.data?.initConnection?.fragments.sDPClientAttrs else {
            throw URLError(.badServerResponse)
        }
        
        return .init(from: sDPClientAttrs)
    }
    
    @discardableResult
    func loadAudio(for roomId: String, audioId: String) async throws -> RoomAttrs {
        
        let mutation = LoadAudioMutation(roomId: roomId, audioId: audioId)
        
        let data = try await api.mutation(mutation: mutation)
        
        guard let room = data.data?.loadAudio?.fragments.roomAttrs else {
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
    
}

enum RoomAction: String {
    case play, pause, move
}

extension RoomAttrs: Identifiable {}
extension FileAttrs: Identifiable {}


extension RoomAttrs {
    
    func userIsOwner(for id: String) -> Bool {
        owner?.id == id
    }
    
    static let mock = RoomAttrs(file: .init(currentSeconds: "120", durationSeconds: "360", file: .init(id: "", name: "Music name"), pause: false), id: "123", likes: 68, private: false, image: "", key: "code", name: "Room name", members: [.init(id: "1", login: "test", avatar: "")])
}
