//
//  ParticlesModifier.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI

fileprivate struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 10 ... 40)
    var direction = Double.random(in: -6 ... -1)
    var translationX = Double.random(in: -1 ... 1)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * translationX * time
        let yTranslation = speed * direction * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}


struct ParticlesModifier: ViewModifier {
    var index: Int
    @State var task: Task<(), Never>?
    @State var time = 0.0
    @State var scale = 0.001
    var speed: Double = Double.random(in: 20...50)
    var duration = 1.0
    var particlesMaxCount: Int = 12
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<particlesMaxCount, id: \.self) { index in
                content
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time, speed: speed))
                    .opacity(((duration-time) / duration))
            }
        }
        .onChange(of: index) { newValue in
            task?.cancel()
            task = Task {
                withAnimation (.easeOut(duration: duration)) {
                    self.time = duration
                    self.scale = 1.25
                }
                try? await Task.sleep(seconds: duration)
                self.scale = 0.001
                self.time = 0
            }
        }
    }
}
