//
//  ColorGradientView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Mini Proyecto 2: Ejemplo de gradientes de color
struct ColorGradientView: View {
    @State private var gradientColors: [Color] = [.blue, .purple, .pink]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Experimenta con Gradientes")
                .font(.title2)
                .fontWeight(.bold)
            
            // Gradiente lineal
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
            
            // Botones para cambiar colores
            HStack(spacing: 15) {
                GradientButton(title: "🔵 Azules", colors: [.blue, .cyan, .mint])
                GradientButton(title: "🔴 Cálidos", colors: [.orange, .red, .pink])
                GradientButton(title: "🟢 Naturales", colors: [.green, .mint, .teal])
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Gradientes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GradientButton: View {
    let title: String
    let colors: [Color]
    
    var body: some View {
        Button(title) {
            // Acción del botón
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
    }
}

#Preview {
    NavigationStack {
        ColorGradientView()
    }
}
