//
//  LazyNukeImage.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 24.11.2023.
//

import SwiftUI
import NukeUI
import Nuke

struct LazyNukeImage: View {
    
    private var url: URL?
    var resizeSize: CGSize
    var contentMode: ImageProcessingOptions.ContentMode
    var loadPriority: ImageRequest.Priority = .normal
    var upscale: Bool
    var crop: Bool
    var loadColor: Color
    private let imagePipeline = ImagePipeline(configuration: .withDataCache)
    
    
    private var resizeProcessor: ImageProcessors.Resize {
        ImageProcessors.Resize.resize(size: resizeSize,
                                      unit: .points,
                                      contentMode: contentMode,
                                      crop: crop,
                                      upscale: upscale)
    }
    
    init(path: String? = nil,
         fullPath: String? = nil,
         resizeSize: CGSize = .init(width: 200, height: 200),
         contentMode: ImageProcessingOptions.ContentMode = .aspectFill,
         loadPriority: ImageRequest.Priority = .normal,
         upscale: Bool = false,
         crop: Bool = true,
         loadColor: Color = .primaryGray) {
        self.resizeSize = resizeSize
        self.contentMode = contentMode
        self.loadPriority = loadPriority
        
        if let path {
            self.url = URL(string: Config.baseURL + path)
        } else if let fullPath {
            self.url = URL(string: fullPath)
        }
        self.crop = crop
        self.upscale = upscale
        self.loadColor = loadColor
       
    }
    var body: some View {
        Group {
            if let url = url {
                LazyImage(url: url, transaction: .init(animation: .easeInOut)) { state in
                    if let image = state.image {
                        image
                            .aspectRatio(contentMode: contentMode == .aspectFill ? .fill : .fit)
                    }
                    else if state.isLoading || state.error != nil {
                        loadColor
                    }
                }
                .processors([resizeProcessor])
                .priority(loadPriority)
                .pipeline(imagePipeline)
            } else {
                errorView
            }
        }
    }
    
    private var errorView: some View {
        ZStack {
            Color.primaryGray
                Image(systemName: "exclamationmark.octagon")
                .font(.xLarge(weight: .bold))
                .foregroundColor(.red)
        }
    }
}
