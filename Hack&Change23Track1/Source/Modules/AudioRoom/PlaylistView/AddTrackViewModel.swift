//
//  AddTrackViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation
import Combine

class AddTrackViewModel: ObservableObject {
    
    @Published private(set) var audios: [FileAttrs] = [
    
        .init(id: "1", name: "Name1\nAuthor name"),
        .init(id: "2", name: "Name2\nAuthor name"),
        .init(id: "3", name: "Name3\nAuthor name")
    ]
    @Published private(set) var searchResult = [FileAttrs]()
    
    @Published private(set) var selectedId: [String] = []
    @Published var searchQuery: String = ""
    private var cancellable = Set<AnyCancellable>()
    
    
    init() {
        listenToSearch()
    }
    
    private func listenToSearch(){
         $searchQuery
             .removeDuplicates()
             .debounce(for: 0.3, scheduler: DispatchQueue.main)
             .sink { [weak self] delayQuery in
                 guard let self = self else {return}
                 if delayQuery.isEmpty {
                     self.searchResult = audios
                 } else {
                     self.searchResult = audios.filter { $0.name?.contains(delayQuery) ?? false }
                 }
             }
             .store(in: &cancellable)
     }
  
    func addOrRemove(for id: String) {
        if selectedId.contains(id) {
            selectedId.removeAll(where: {$0 == id})
        } else {
            selectedId.append(id)
        }
    }
}
