//
//  ApolloClient.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import ApolloAPI
import Combine
import Apollo

class Network {

    static let shared = Network()

    private init() { }

    private(set) lazy var client: ApolloClient = {
        let url = URL(string: Config.baseURL + "/api")!
        let client = URLSessionClient()
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let provider = NetworkInterceptorProvider(store: store, client: client)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

extension Network {

    struct NetworkInterceptorProvider: InterceptorProvider {
        private let store: ApolloStore
        private let client: URLSessionClient

        init(store: ApolloStore,
             client: URLSessionClient) {
            self.store = store
            self.client = client
        }

        func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
            return [
                MaxRetryInterceptor(),
                CacheReadInterceptor(store: self.store),
                UserManagementInterceptor(),
                NetworkFetchInterceptor(client: self.client),
                ResponseCodeInterceptor(),
                JSONResponseParsingInterceptor(),
                AutomaticPersistedQueryInterceptor(),
                CacheWriteInterceptor(store: self.store),
//                RequestLoggingInterceptor(),
//                ResponseLoggingInterceptor()
            ]
        }
    }
}

extension Network {

    class UserManagementInterceptor: ApolloInterceptor {

        public var id: String = UUID().uuidString

        /// Helper function to add the token then move on to the next step
        private func addTokenAndProceed<Operation: GraphQLOperation>(
            _ token: String?,
            to request: HTTPRequest<Operation>,
            chain: RequestChain,
            response: HTTPResponse<Operation>?,
            completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
        ) {
            if let token {
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
            }
            chain.proceedAsync(
                request: request,
                response: response,
                interceptor: self,
                completion: completion
            )
        }

        func interceptAsync<Operation: GraphQLOperation>(
            chain: RequestChain,
            request: HTTPRequest<Operation>,
            response: HTTPResponse<Operation>?,
            completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
        ) {
            let token = UserDefaults.standard.string(forKey: "JWT")

            self.addTokenAndProceed(
                token,
                to: request,
                chain: chain,
                response: response,
                completion: completion
            )
        }
    }
}

extension Network {

    class RequestLoggingInterceptor: ApolloInterceptor {

        public var id: String = UUID().uuidString

        func interceptAsync<Operation: GraphQLOperation>(
            chain: RequestChain,
            request: HTTPRequest<Operation>,
            response: HTTPResponse<Operation>?,
            completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
        ) {
            print("Outgoing request: \(request)")
            chain.proceedAsync(
                request: request,
                response: response,
                interceptor: self,
                completion: completion
            )
        }
    }

    class ResponseLoggingInterceptor: ApolloInterceptor {

        public var id: String = UUID().uuidString

        func interceptAsync<Operation: GraphQLOperation>(
            chain: RequestChain,
            request: HTTPRequest<Operation>,
            response: HTTPResponse<Operation>?,
            completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
        ) {
            defer {
                // Even if we can't log, we still want to keep going.
                chain.proceedAsync(
                    request: request,
                    response: response,
                    interceptor: self,
                    completion: completion
                )
            }

            guard let receivedResponse = response else {
                chain.handleErrorAsync(
                    URLError(URLError.badServerResponse),
                    request: request,
                    response: response,
                    completion: completion
                )
                return
            }

            print("HTTP Response: \(receivedResponse.httpResponse)")

            if let stringData = String(bytes: receivedResponse.rawData, encoding: .utf8) {
                print("Data: \(stringData)")
            } else {
                print("Could not convert data to string!")
            }
        }
    }
}


