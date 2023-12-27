//
//  RoomChatDataService.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 22.12.2023.
//

import Foundation
import Apollo
import SchemaAPI
import Combine

final class RoomChatDataService {
    
    private let splitClient = Network.shared.splitClient
    
    @discardableResult
    func sendMessage(for roomId: String, _ message: MessageInput) async throws -> Bool {
        let mutation = SendMessageMutation(roomId: roomId, message: message)
        
        let result = try await splitClient?.mutation(mutation: mutation)
        
        guard let result = result?.data?.sendMessage else {
            throw AppError.network(type: .somethingWentWrong)
        }
        return result
    }
    
    @discardableResult
    func sendReaction(roomId: String, messageId: String, reaction: String) async throws -> Bool {
        let mutation = SendReactionMutation(messageId: messageId, reaction: reaction, roomId: roomId)
        
        let result = try await splitClient?.mutation(mutation: mutation)
        
        guard let result = result?.data?.sendReaction else {
            throw AppError.network(type: .somethingWentWrong)
        }
        return result
    }
    
    @discardableResult
    func hiddenMessage(roomId: String, messageId: String)  async throws -> Bool {
        let mutation = HideMessageMutation(roomId: roomId, messageId: messageId)
        
        let result = try await splitClient?.mutation(mutation: mutation)
        
        guard let result = result?.data?.hideMessage else {
            throw AppError.network(type: .somethingWentWrong)
        }
        return result
    }
    
    func subscribeToRoomChat(for roomId: String) ->
    AnyPublisher<SubscribeChatSubscription.Data.SubscribeChat?, Error> {
        print(roomId)
        guard let splitClient else {
            return Fail(error: AppError.network(type: .somethingWentWrong)).eraseToAnyPublisher()
        }
        let subscription = SubscribeChatSubscription(roomId: roomId)
        return splitClient.subscribePublisher(subscription: subscription, queue: .global(qos: .userInitiated))
            .tryMap {
                if let error = $0.errors?.first {
                    print("subscribeToRoomChat", error)
                    throw error
                }
                if let data = $0.data?.subscribeChat {
                    print(data)
                    return data
                }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    func subscribeToRoomChat2(for roomId: String) throws -> AsyncThrowingStream<GraphQLResult<SubscribeChatSubscription.Data>, any Error> {
        guard let splitClient else {
            throw AppError.network(type: .somethingWentWrong)
        }
        let subscription = SubscribeChatSubscription(roomId: roomId)
        return splitClient.subscribe(subscription: subscription)
    }
}
