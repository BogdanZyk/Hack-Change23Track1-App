//
//  AddTrackView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct AddTrackView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: AddTrackViewModel
    private let onSubmit: ([VideoItem]) -> Void
    
    init(selectedAudios: [VideoItem], onSubmit: @escaping ([VideoItem]) -> Void) {
        let files = selectedAudios.map { $0.file }
        self._viewModel = StateObject(wrappedValue: AddTrackViewModel(selectedAudios: files))
        self.onSubmit = onSubmit
    }
    var body: some View {
        VStack(spacing: 0) {
            topBarView
            PrimaryTextField(text: $viewModel.searchQuery, label: "Search")
                .padding()
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.searchResult){
                        rowView($0)
                    }
                }
            }
            .padding()
        }
        .background(Color.primaryBg)
        .foregroundColor(.primaryFont)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            addButton
        }
        .task {
            await viewModel.fetchVideos()
        }
    }
}

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackView(selectedAudios: [], onSubmit: {_ in })
    }
}

extension AddTrackView {
    private var topBarView: some View {
        Text("Add tracks")
            .font(.primary(weight: .semibold))
            .hCenter()
            .overlay(alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
    }
    
    @ViewBuilder
    private func rowView(_ video: SourceAttrs) -> some View {
        let isSelected = viewModel.selectedVideo.contains(where: {$0.id == video.id})
        HStack(spacing: 15) {
            LazyNukeImage(fullPath: video.coverFullPath)
                .frame(width: 54, height: 54)
                .cornerRadius(8)
            Text(video.name ?? "no name")
            Spacer()
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundColor(.primaryPink)
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.addOrRemove(for: video)
        }
    }
    
    @ViewBuilder
    private var addButton: some View {
        let countTrack = viewModel.selectedVideo.count
        if countTrack > 0 {
            PrimaryButton(label: "Added \(countTrack) tracks", isLoading: false) {
                dismiss()
                onSubmit(viewModel.selectedVideo.compactMap({.init(file: $0, status: .wait)}))
            }
            .padding()
        }
    }
}
