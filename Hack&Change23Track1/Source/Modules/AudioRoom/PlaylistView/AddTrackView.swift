//
//  AddTrackView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct AddTrackView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddTrackViewModel()
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
    }
}

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackView()
    }
}

extension AddTrackView {
    private var topBarView: some View {
        Text("Add tracks")
            .font(.primary())
            .hCenter()
            .overlay(alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
    }
    
    @ViewBuilder
    private func rowView(_ audio: FileAttrs) -> some View {
        let isSelected = viewModel.selectedId.contains(audio.id ?? "")
        HStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.secondary)
                .frame(width: 54, height: 54)
            Text(audio.name ?? "no name")
            Spacer()
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundColor(.primaryPink)
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.addOrRemove(for: audio.id ?? "1")
        }
    }
    
    @ViewBuilder
    private var addButton: some View {
        let countTrack = viewModel.selectedId.count
        if countTrack > 0 {
            PrimaryButton(label: "Added \(countTrack) tracks", isLoading: false) {
                dismiss()
            }
            .padding()
        }
    }
}
