//
//  SoundWaveView.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

struct SoundWaveView: View {
    
    @State private var drawingHeight = true
    var color: Color = .secondary
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
    let data = [
        (lvl: 0.4, speed: 1.5),
        (lvl: 0.3, speed: 1.2),
        (lvl: 0.5, speed: 1.0),
        (lvl: 0.3, speed: 1.7),
        (lvl: 0.5, speed: 1.0),
    ]
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: proxy.size.width > 80 ? 10 : 4) {
                ForEach(data.indices, id: \.self){ index in
                    bar(low: data[index].lvl, height: proxy.size.height)
                        .animation(animation.speed(data[index].speed), value: drawingHeight)
                }
            }
        }
        .onAppear{
            drawingHeight.toggle()
        }
    }
    
    func bar(low: CGFloat = 0.1, high: CGFloat = 1.0, height: CGFloat) -> some View {
        Capsule()
            .fill(color.gradient)
            .frame(height: (drawingHeight ? high : low) * height)
            .frame(maxHeight: height, alignment: .center)
    }
    
}

struct SoundWaveView_Previews: PreviewProvider {
    static var previews: some View {
        SoundWaveView()
            .frame(width: 80, height: 80, alignment: .center)
            //.background(.secondary)
    }
}
