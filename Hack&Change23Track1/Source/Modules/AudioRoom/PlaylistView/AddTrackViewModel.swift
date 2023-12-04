//
//  AddTrackViewModel.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation
import Combine

class AddTrackViewModel: ObservableObject {
    
    @Published private(set) var videos: [SourceAttrs] = []
    @Published private(set) var searchResult = [SourceAttrs]()
    @Published private(set) var selectedVideo: [SourceAttrs] = []
    
    @Published var searchQuery: String = ""
    private var cancellable = Set<AnyCancellable>()
    private let roomDataService = RoomDataService()
    
    init(selectedAudios: [SourceAttrs]) {
        self.selectedVideo = selectedAudios
        listenToSearch()
    }
    
    private func listenToSearch(){
         $searchQuery
             .removeDuplicates()
             .debounce(for: 0.3, scheduler: DispatchQueue.main)
             .sink { [weak self] delayQuery in
                 guard let self = self else {return}
                 if delayQuery.isEmpty {
                     self.searchResult = videos
                 } else {
                     self.searchResult = videos.filter { $0.name?.contains(delayQuery) ?? false }
                 }
             }
             .store(in: &cancellable)
     }
  
    @MainActor
    func fetchAudios() async {
        let audios = try? await roomDataService.fetchAudios()
        self.videos = audios ?? []
    }
    
    func addOrRemove(for video: SourceAttrs) {
        if selectedVideo.contains(where: {$0.id == video.id}) {
            selectedVideo.removeAll(where: {$0.id == video.id})
        } else {
            selectedVideo.append(video)
        }
    }
}
