//
//  WebSocketService.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation

protocol WebSocketProvider: AnyObject {
    var delegate: WebSocketProviderDelegate? { get set }
    func connect()
    func send(data: Data) async throws
    func disconnect()
}

protocol WebSocketProviderDelegate: AnyObject {
    func webSocketDidConnect(_ webSocket: WebSocketProvider)
    func webSocketDidDisconnect(_ webSocket: WebSocketProvider)
    func webSocket(_ webSocket: WebSocketProvider, didReceiveData data: Data)
}

final class WebSocketService: NSObject, WebSocketProvider {
    
    weak var delegate: WebSocketProviderDelegate?
    private let request: URLRequest
    private var socket: URLSessionWebSocketTask?

    init(url: String, token: String?) {
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        self.request = request
        super.init()
    }

    func connect() {
        let socket = URLSession.shared.webSocketTask(with: request)
        socket.resume()
        self.socket = socket
        readMessage()
    }

    func send(data: Data) async throws {
        try await socket?.send(.data(data))
    }
    
    private func readMessage() {
        self.socket?.receive { [weak self] message in
            guard let self = self else { return }
            
            switch message {
            case .success(.string(let str)):
                guard let data = str.data(using: .utf8) else { return }
                self.delegate?.webSocket(self, didReceiveData: data)
                self.readMessage()
            case .success:
                self.readMessage()
            case .failure:
                self.disconnect()
            }
        }
    }
    
    func disconnect() {
        self.socket?.cancel()
        self.socket = nil
        self.delegate?.webSocketDidDisconnect(self)
    }
}

extension WebSocketService: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("webSocketDidConnect")
        self.delegate?.webSocketDidConnect(self)
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("webSocketDidClose")
        self.disconnect()
    }
}
