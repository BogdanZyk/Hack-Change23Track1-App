//
//  Apollo+Extensions.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import Apollo
import ApolloAPI
import Combine

extension ApolloClient {

    func mutation<T>(mutation: T,
                     queue: DispatchQueue = .main,
                     publishResultToStore: Bool = true) async throws -> GraphQLResult<T.Data> where T: GraphQLMutation {

        try await withCheckedThrowingContinuation { continuation in
            perform(mutation: mutation,
                    publishResultToStore: publishResultToStore,
                    queue: queue) { result in
                switch result {
                case .success(let result):
                    if let error = result.errors?.first {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: result)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

extension ApolloClient {
    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .default,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Query.Data>? {
        try await AsyncThrowingStream { continuation in
            let request = fetch(
                query: query,
                cachePolicy: cachePolicy,
                contextIdentifier: contextIdentifier,
                queue: queue
            ) { response in
                switch response {
                case .success(let result):

                    if let error = result.errors?.first {
                        continuation.finish(throwing: error)
                    }

                    continuation.yield(result)

                    if result.isFinalForCachePolicy(cachePolicy) {
                        continuation.finish()
                    }
                case .failure(let error):
                    continuation.finish(throwing: error)
                }
            }
            continuation.onTermination = { @Sendable _ in request.cancel() }
        }.first(where: {_ in true})
    }
    
    public func subscribe<Subscription: GraphQLSubscription>(subscription: Subscription) -> AsyncThrowingStream<GraphQLResult<Subscription.Data>, Error> {
        
        AsyncThrowingStream { continuation in

            let subs = self.subscribe(subscription: subscription) { result in
                 switch result {
                 
                 case .success(let result):
                     if let error = result.errors?.first {
                         continuation.finish(throwing: error)
                     }
                     continuation.yield(result)
                 case .failure(let error):
                     continuation.finish(throwing: error)
                 }
             }
            continuation.onTermination = { @Sendable _ in subs.cancel() }
        }
    }
}

extension GraphQLResult {
    func isFinalForCachePolicy(_ cachePolicy: CachePolicy) -> Bool {
        switch cachePolicy {
        case .returnCacheDataElseFetch:
            return true
        case .fetchIgnoringCacheData:
            return source == .server
        case .fetchIgnoringCacheCompletely:
            return source == .server
        case .returnCacheDataDontFetch:
            return source == .cache
        case .returnCacheDataAndFetch:
            return source == .server
        }
    }
}

extension ApolloClient {
    
    func subscribePublisher<Subscription: GraphQLSubscription>(subscription: Subscription, queue: DispatchQueue = .main)
    -> GraphQLSubscriptionPublisher<Subscription> {
        GraphQLSubscriptionPublisher(client: self, queue: queue, subscription: subscription)
    }
}

public final class GraphQLSubscriptionSubscription<GraphSubscription: GraphQLSubscription, SubscriberType: Subscriber>: Subscription
where SubscriberType.Input == GraphQLResult<GraphSubscription.Data>, SubscriberType.Failure == Error {
    
    private var subscriber: SubscriberType?
    private var cancellable: Apollo.Cancellable? = nil
    
    public init(client: ApolloClient,
                queue: DispatchQueue,
                subscription: GraphSubscription,
                subscriber: SubscriberType) {
        
        self.subscriber = subscriber
        cancellable = client.subscribe(
            subscription: subscription,
            queue: queue,
            resultHandler: self.handle)
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    public func request(_ demand: Subscribers.Demand) { }
    
    public func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }
    
    private func handle(result: Result<GraphQLResult<GraphSubscription.Data>, Error>) {
        switch result {
        case .success(let resultSet):
            _ = subscriber?.receive(resultSet)
        case .failure(let e):
            subscriber?.receive(completion: Subscribers.Completion<Error>.failure(e))
            subscriber?.receive(completion: .finished)
        }
    }
}

public struct GraphQLSubscriptionPublisher<Subscription: GraphQLSubscription>: Publisher {
    public typealias Output = GraphQLResult<Subscription.Data>
    public typealias Failure = Error
    
    private let client: ApolloClient
    private let subscription: Subscription
    private let queue: DispatchQueue
    
    init(client: ApolloClient,
         queue: DispatchQueue,
         subscription: Subscription) {
        
        self.client = client
        self.queue = queue
        self.subscription = subscription
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Error, S.Input == GraphQLResult<Subscription.Data> {
        let subscription = GraphQLSubscriptionSubscription(client: client,
                                                           queue: queue,
                                                           subscription: subscription,
                                                           subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}
