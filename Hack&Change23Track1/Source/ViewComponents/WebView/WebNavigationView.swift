//
//  WebNavigationView.swift
//  TestApp1
//
//  Created by Bogdan Zykov on 06.12.2023.
//

import SwiftUI

struct WebNavigationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = WebViewModel()
    let url = "https://www.youtube.com/"
    var withDismiss: Bool = true
    let onSelect: (String) -> Void
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if withDismiss {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .padding()
                    Spacer()
                }
            }
            WebView(url: url, viewModel: viewModel)
                .ignoresSafeArea()
        }
        .background(Color.primaryBg)
        .onChange(of: viewModel.videoId) { newValue in
            guard let newValue else {return}
            onSelect(newValue)
            if withDismiss {
                dismiss()
            }
        }
    }
}

