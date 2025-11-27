//
//  AnimatedStrokeButtonView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/25/25.
//

import SwiftUI

/// Mini Proyecto 1: Botón con borde animado
struct AnimatedStrokeButtonView: View {
    @State private var tapCount = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Animated Stroke Button")
                .font(.title)
                .fontWeight(.bold)
            
            AnimatedStrokeButton(title: "Tap Me!") {
                tapCount += 1
            }
            
            Text("Tapped \(tapCount) times")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Animated Button")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// An animated stroke button that continuously animates its border
struct AnimatedStrokeButton: View {
    let title: String
    let action: () -> Void
    
    // Animation state for the stroke
    @State private var animationAmount: CGFloat = 0
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.black)
                        .stroke(
                            AngularGradient(
                                colors: [.blue, .orange, .blue],
                                center: .center,
                                startAngle: .degrees(animationAmount),
                                endAngle: .degrees(animationAmount + 360)
                            ),
                            lineWidth: 5
                        )
                )
        }
        .onAppear {
            // Continuously rotate the gradient for an animated stroke effect
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                animationAmount = 360
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnimatedStrokeButtonView()
    }
}
