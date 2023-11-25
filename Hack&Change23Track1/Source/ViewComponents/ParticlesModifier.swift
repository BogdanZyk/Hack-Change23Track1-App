//
//  ParticlesModifier.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import SwiftUI


struct ReactionButtonView: View {
    var index: Int = 0
    @State var particles = [Particle]()
    let duration = 1.0
    let action: () -> Void
    var body: some View {
        VStack {
            
            Button {
                action()
            } label: {
                Image(systemName: "suit.heart")
                    .font(.title2)
                    .foregroundColor(.primaryFont)
            }
            .overlay(alignment: .top) {
                ZStack {
                    ForEach(particles) { particle in
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(.red)
                            .offset(x: particle.offset.x, y: particle.offset.y)
                            .opacity(particle.opacity)
                            .scaleEffect(particle.scale)
                    }
                }
            }
            .onChange(of: index) { newValue in
                    particles.append(.init())
                withAnimation(.easeInOut(duration: duration)) {
                    particles[particles.count - 1].move()
                }
                
                Task {
                    try? await Task.sleep(seconds: duration)
                    withAnimation {
                        particles.removeLast()
                    }
                }
            }
        }
    }
    
    struct Particle: Identifiable {
        var id: UUID = .init()
        var offset: CGPoint = .zero
        var opacity: CGFloat = 1
        var scale: CGFloat = 1
        
        mutating func move() {
            offset = .init(x: Double.random(in: -30 ... 30),
                           y: Double.random(in: -100 ... -80))
            opacity = Double.random(in: 0.3 ... 1)
            scale = Double.random(in: 1.5 ... 1.8)
        }
    }
}


struct ReactionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionButtonView(action: {})
    }
}


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
