//
//  IconScrollBarView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/27/25.
//

import SwiftUI

/// Mini Project 4: Scrollable Icon Selection Bar
struct IconScrollBarView: View {
    // State to track the selected icon
    @State private var selectedIcon: IconItem? = nil
    @State private var showingInfo = false
    
    // Available icons list
    let icons: [IconItem] = [
        IconItem(name: "house.fill", title: "Home", color: .blue, description: "A cozy place to live"),
        IconItem(name: "heart.fill", title: "Heart", color: .red, description: "Symbol of love and passion"),
        IconItem(name: "star.fill", title: "Star", color: .yellow, description: "Shines in the night sky"),
        IconItem(name: "bolt.fill", title: "Bolt", color: .orange, description: "Power and energy"),
        IconItem(name: "moon.fill", title: "Moon", color: .purple, description: "Light in the darkness"),
        IconItem(name: "sun.max.fill", title: "Sun", color: .orange, description: "Source of light and heat"),
        IconItem(name: "cloud.fill", title: "Cloud", color: .gray, description: "Floats in the sky"),
        IconItem(name: "flame.fill", title: "Fire", color: .red, description: "Hot and bright"),
        IconItem(name: "drop.fill", title: "Drop", color: .blue, description: "Crystal clear water"),
        IconItem(name: "leaf.fill", title: "Leaf", color: .green, description: "Nature and life"),
        IconItem(name: "snowflake", title: "Snow", color: .cyan, description: "Winter cold"),
        IconItem(name: "camera.fill", title: "Camera", color: .indigo, description: "Capture moments"),
        IconItem(name: "music.note", title: "Music", color: .pink, description: "Harmonious melodies"),
        IconItem(name: "gamecontroller.fill", title: "Games", color: .purple, description: "Fun and entertainment"),
        IconItem(name: "book.fill", title: "Book", color: .brown, description: "Knowledge and wisdom"),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Selected icon display area
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
            
            // Horizontal scrollable icon bar
            VStack(alignment: .leading, spacing: 12) {
                Text("Select an icon")
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
        .navigationTitle("Icons")
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
                title: "Scrollable Icon Bar",
                content: ProjectInfoContent.iconScrollBar
            )
        }
    }
}

// MARK: - Selected Icon View

struct SelectedIconView: View {
    let icon: IconItem
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Large icon with animation
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
            
            // Icon information
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

// MARK: - Empty Selection View

struct EmptySelectionView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hand.tap.fill")
                .font(.system(size: 60))
                .foregroundStyle(.gray.opacity(0.3))
            
            Text("Select an icon")
                .font(.title3)
                .foregroundStyle(.secondary)
            
            Text("Scroll and tap any icon below")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

// MARK: - Individual Icon Button

struct IconButton: View {
    let icon: IconItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    // Button background
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
                    
                    // Icon
                    Image(systemName: icon.name)
                        .font(.system(size: 28))
                        .foregroundStyle(isSelected ? icon.color : .primary)
                }
                .scaleEffect(isSelected ? 1.05 : 1.0)
                
                // Icon title
                Text(icon.title)
                    .font(.caption)
                    .foregroundStyle(isSelected ? icon.color : .secondary)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Data Model

struct IconItem: Identifiable, Equatable {
    let id = UUID()
    let name: String       // SF Symbol name
    let title: String      // Display title
    let color: Color       // Icon color
    let description: String // Icon description
}

// MARK: - Preview

#Preview {
    NavigationStack {
        IconScrollBarView()
    }
}
