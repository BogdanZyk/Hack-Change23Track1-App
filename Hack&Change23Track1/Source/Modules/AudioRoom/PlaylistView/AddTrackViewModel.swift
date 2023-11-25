//
//  AddTrackViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation

class AddTrackViewModel: ObservableObject {
    
    @Published private(set) var audios: [FileAttrs] = [
    
        .init(id: "1", name: "Name1\nAuthor name"),
        .init(id: "2", name: "Name2\nAuthor name"),
        .init(id: "3", name: "Name3\nAuthor name")
    ]
    @Published private(set) var selectedId: [String] = []
    
    @Published var searchQuery: String = ""
    
    
    func addOrRemove(for id: String) {
        if selectedId.contains(id) {
            selectedId.removeAll(where: {$0 == id})
        } else {
            selectedId.append(id)
        }
    }
}
