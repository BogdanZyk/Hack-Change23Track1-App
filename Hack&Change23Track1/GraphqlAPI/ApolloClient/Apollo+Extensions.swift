//
//  Apollo+Extensions.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import Apollo
import ApolloAPI

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

