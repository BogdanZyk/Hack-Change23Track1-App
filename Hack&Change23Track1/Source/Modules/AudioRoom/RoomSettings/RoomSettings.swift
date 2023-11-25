//
//  RoomSettings.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct RoomSettings: View {
    @ObservedObject var viewModel: RoomViewModel
    var body: some View {
        VStack{
            
        }
    }
}

struct RoomSettings_Previews: PreviewProvider {
    static var previews: some View {
        RoomSettings(viewModel: .init(room: .mock, currentUser: .mock))
    }
}
