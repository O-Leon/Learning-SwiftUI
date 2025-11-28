//
//  ColorGradientView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Mini Project 2: Color Gradient Experiments
struct ColorGradientView: View {
    @State private var gradientColors: [Color] = [.blue, .purple, .pink]
    @State private var showingInfo = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Experiment with Gradients")
                .font(.title2)
                .fontWeight(.bold)
            
            // Linear gradient
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)
                .padding(.horizontal)
            
            // Buttons to change colors
            HStack(spacing: 15) {
                GradientButton(title: "🔵 Blues", colors: [.blue, .cyan, .mint]) {
                    withAnimation {
                        gradientColors = [.blue, .cyan, .mint]
                    }
                }
                GradientButton(title: "🔴 Warm", colors: [.orange, .red, .pink]) {
                    withAnimation {
                        gradientColors = [.orange, .red, .pink]
                    }
                }
                GradientButton(title: "🟢 Natural", colors: [.green, .mint, .teal]) {
                    withAnimation {
                        gradientColors = [.green, .mint, .teal]
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Gradients")
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
                title: "Color Gradients",
                content: ProjectInfoContent.colorGradient
            )
        }
    }
}

struct GradientButton: View {
    let title: String
    let colors: [Color]
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(.bordered)
            .controlSize(.small)
    }
}

#Preview {
    NavigationStack {
        ColorGradientView()
    }
}
