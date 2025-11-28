//
//  IconScrollBarView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/27/25.
//

import SwiftUI

/// Mini Proyecto 4: Barra desplazable de íconos seleccionables
struct IconScrollBarView: View {
    // Estado para rastrear el ícono seleccionado
    @State private var selectedIcon: IconItem? = nil
    
    // Lista de íconos disponibles
    let icons: [IconItem] = [
        IconItem(name: "house.fill", title: "Casa", color: .blue, description: "Un lugar acogedor para vivir"),
        IconItem(name: "heart.fill", title: "Corazón", color: .red, description: "Símbolo de amor y pasión"),
        IconItem(name: "star.fill", title: "Estrella", color: .yellow, description: "Brilla en el cielo nocturno"),
        IconItem(name: "bolt.fill", title: "Rayo", color: .orange, description: "Poder y energía"),
        IconItem(name: "moon.fill", title: "Luna", color: .purple, description: "Luz en la oscuridad"),
        IconItem(name: "sun.max.fill", title: "Sol", color: .orange, description: "Fuente de luz y calor"),
        IconItem(name: "cloud.fill", title: "Nube", color: .gray, description: "Flota en el cielo"),
        IconItem(name: "flame.fill", title: "Fuego", color: .red, description: "Caliente y brillante"),
        IconItem(name: "drop.fill", title: "Gota", color: .blue, description: "Agua cristalina"),
        IconItem(name: "leaf.fill", title: "Hoja", color: .green, description: "Naturaleza y vida"),
        IconItem(name: "snowflake", title: "Copo", color: .cyan, description: "Frío invernal"),
        IconItem(name: "camera.fill", title: "Cámara", color: .indigo, description: "Captura momentos"),
        IconItem(name: "music.note", title: "Música", color: .pink, description: "Melodías armoniosas"),
        IconItem(name: "gamecontroller.fill", title: "Juegos", color: .purple, description: "Diversión y entretenimiento"),
        IconItem(name: "book.fill", title: "Libro", color: .brown, description: "Conocimiento y sabiduría"),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Área de visualización del ícono seleccionado
            if let selected = selectedIcon {
                SelectedIconView(icon: selected)
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
            } else {
                EmptySelectionView()
            }
            
            Divider()
                .padding(.vertical, 20)
            
            // Barra horizontal desplazable de íconos
            VStack(alignment: .leading, spacing: 12) {
                Text("Selecciona un ícono")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(icons) { icon in
                            IconButton(
                                icon: icon,
                                isSelected: selectedIcon?.id == icon.id
                            ) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedIcon = icon
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
            .background(Color(.systemGray6))
            
            Spacer()
        }
        .navigationTitle("Íconos")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Vista del ícono seleccionado

struct SelectedIconView: View {
    let icon: IconItem
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Ícono grande con animación
            ZStack {
                Circle()
                    .fill(icon.color.opacity(0.2))
                    .frame(width: 140, height: 140)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                
                Image(systemName: icon.name)
                    .font(.system(size: 60))
                    .foregroundStyle(icon.color)
            }
            
            // Información del ícono
            VStack(spacing: 8) {
                Text(icon.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(icon.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Vista cuando no hay selección

struct EmptySelectionView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hand.tap.fill")
                .font(.system(size: 60))
                .foregroundStyle(.gray.opacity(0.3))
            
            Text("Selecciona un ícono")
                .font(.title3)
                .foregroundStyle(.secondary)
            
            Text("Desliza y toca cualquier ícono de abajo")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

// MARK: - Botón de ícono individual

struct IconButton: View {
    let icon: IconItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    // Fondo del botón
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? icon.color.opacity(0.2) : Color(.systemBackground))
                        .frame(width: 70, height: 70)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(
                                    isSelected ? icon.color : Color(.systemGray4),
                                    lineWidth: isSelected ? 3 : 1
                                )
                        )
                    
                    // Ícono
                    Image(systemName: icon.name)
                        .font(.system(size: 28))
                        .foregroundStyle(isSelected ? icon.color : .primary)
                }
                .scaleEffect(isSelected ? 1.05 : 1.0)
                
                // Título del ícono
                Text(icon.title)
                    .font(.caption)
                    .foregroundStyle(isSelected ? icon.color : .secondary)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Modelo de datos

struct IconItem: Identifiable, Equatable {
    let id = UUID()
    let name: String       // Nombre del SF Symbol
    let title: String      // Título para mostrar
    let color: Color       // Color del ícono
    let description: String // Descripción del ícono
}

// MARK: - Preview

#Preview {
    NavigationStack {
        IconScrollBarView()
    }
}
