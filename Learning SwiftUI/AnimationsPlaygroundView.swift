//
//  AnimationsPlaygroundView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Mini Project 3: Animations Playground
struct AnimationsPlaygroundView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0
    @State private var offset: CGFloat = 0
    @State private var isMorphed: Bool = false
    @State private var showingInfo = false
    
    var body: some View {
        VStack(spacing: 40) {
            // Animated element with morph capability
            ZStack {
                if isMorphed {
                    Circle()
                        .fill(.purple)
                        .frame(width: 100, height: 100)
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                        .offset(y: offset)
                        .transition(.scale.combined(with: .opacity))
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.blue)
                        .frame(width: 100, height: 100)
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                        .offset(y: offset)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            
            // Controls
            VStack(spacing: 20) {
                Button("Scale") {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                        scale = scale == 1.0 ? 1.5 : 1.0
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Rotate") {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        rotation += 360
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Move") {
                    withAnimation(.bouncy) {
                        offset = offset == 0 ? 100 : 0
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Morph Shape") {
                    withAnimation(.smooth(duration: 0.8)) {
                        isMorphed.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(isMorphed ? .purple : .blue)
                
                Button("Reset") {
                    withAnimation {
                        scale = 1.0
                        rotation = 0
                        offset = 0
                        isMorphed = false
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .navigationTitle("Animations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingInfo = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showingInfo) {
            ProjectInfoSheet(
                title: "Animations Playground",
                content: ProjectInfoContent.animationsPlayground
            )
        }
    }
}

#Preview {
    NavigationStack {
        AnimationsPlaygroundView()
    }
}
