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
    @Published private(set) var selectedAudios: [FileAttrs] = []
    
    @Published var searchQuery: String = ""
    private var cancellable = Set<AnyCancellable>()
    private let roomDataService = RoomDataService()
    
    init(selectedAudios: [FileAttrs]) {
        self.selectedAudios = selectedAudios
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
  
    @MainActor
    func fetchAudios() async {
        let audios = try? await roomDataService.fetchAudios()
        self.audios = audios ?? []
    }
    
    func addOrRemove(for audio: FileAttrs) {
        if selectedAudios.contains(where: {$0.id == audio.id}) {
            selectedAudios.removeAll(where: {$0.id == audio.id})
        } else {
            selectedAudios.append(audio)
        }
    }
}
