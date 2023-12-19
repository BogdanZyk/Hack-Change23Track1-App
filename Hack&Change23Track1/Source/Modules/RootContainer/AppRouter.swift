//
//  AppRouter.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 14.12.2023.
//

import Foundation
import SchemaAPI

final class AppRouter: ObservableObject {
    
    @Published var pathDestination = [RouterDestination]()
    
    func setPath(to destination: RouterDestination) {
        pathDestination.append(destination)
    }
    
    func popToRoot() {
        pathDestination = []
    }
}


extension AppRouter {
    
    enum RouterDestination: Hashable {
        
        case room(RoomAttrs)
        case createRoom
        case joinRoom
    }
    
}
