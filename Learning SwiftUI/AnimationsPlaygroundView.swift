//
//  AnimationsPlaygroundView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Mini Proyecto 3: Playground de animaciones
struct AnimationsPlaygroundView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 40) {
            // Elemento animado
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue)
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                .offset(y: offset)
            
            // Controles
            VStack(spacing: 20) {
                Button("Escalar") {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                        scale = scale == 1.0 ? 1.5 : 1.0
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Rotar") {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        rotation += 360
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Mover") {
                    withAnimation(.bouncy) {
                        offset = offset == 0 ? 100 : 0
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reset") {
                    withAnimation {
                        scale = 1.0
                        rotation = 0
                        offset = 0
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .navigationTitle("Animaciones")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AnimationsPlaygroundView()
    }
}
