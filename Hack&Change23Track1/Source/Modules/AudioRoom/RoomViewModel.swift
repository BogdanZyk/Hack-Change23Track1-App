//
//  RoomViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import Foundation
import WebRTC
import Combine

@MainActor
final class RoomViewModel: ObservableObject {
    
    //@Published var audioState = AudioUIState()
    @Published var appAlert: AppAlert?
    @Published private(set) var room: RoomAttrs
    @Published private(set) var roomCountLikes: Int = 0
    @Published private(set) var members: [String: RoomMember] = [:]
    @Published private(set) var audios = [FileAttrs]()
    @Published private(set) var currentAudio: FileAttrs?
    @Published private(set) var status: WebRTCStatus = .new
    @Published private(set) var isMute: Bool = false
    
   // private(set) var receivedMessage = PassthroughSubject<Message, Never>()
    
    let currentUser: RoomMember
    private let roomDataService = RoomDataService()
    private let webRTCClient: WebRTCClient
    // private let stream = WebSocketStream(url: "\(Config.socketURL)/api/websocket/candidate")
   // private let webSocketClient: WebSocketService
    
    init(room: RoomAttrs,
         currentUser: RoomMember,
         client: WebRTCClient = .init(iceServers: Config.defaultIceServers)) {
        
//        let token = UserDefaults.standard.string(forKey: "JWT")!
//        webSocketClient = .init(webSocket: WebSocketClient(url: "\(Config.socketURL)/api/websocket/candidate", token: token))
        
        self.room = room
        self.roomCountLikes = room.likes ?? 0
        self.currentUser = currentUser
        self.webRTCClient = client
        //self.webRTCClient.delegate = self
        //self.setMembers()
        //connectWebSocket()
    }
}
