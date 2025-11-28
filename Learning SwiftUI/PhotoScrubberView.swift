//
//  PhotoScrubberView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/27/25.
//

import SwiftUI

/// Mini Project 5: Photo Scrubber with Fixed Center Selector (Apple Photos Style)
struct PhotoScrubberView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var showingInfo = false
    
    // Sample photo data
    let photos: [PhotoItem] = [
        PhotoItem(id: 1, color: .red, icon: "sunrise.fill", title: "Sunrise", description: "Morning golden hour"),
        PhotoItem(id: 2, color: .orange, icon: "sun.max.fill", title: "Noon", description: "Bright daylight"),
        PhotoItem(id: 3, color: .yellow, icon: "sunset.fill", title: "Sunset", description: "Evening warmth"),
        PhotoItem(id: 4, color: .purple, icon: "moon.stars.fill", title: "Night", description: "Starry sky"),
        PhotoItem(id: 5, color: .blue, icon: "cloud.rain.fill", title: "Rain", description: "Rainy weather"),
        PhotoItem(id: 6, color: .green, icon: "leaf.fill", title: "Nature", description: "Green forest"),
        PhotoItem(id: 7, color: .pink, icon: "heart.fill", title: "Love", description: "Romantic moment"),
        PhotoItem(id: 8, color: .indigo, icon: "camera.fill", title: "Photography", description: "Creative shot"),
        PhotoItem(id: 9, color: .cyan, icon: "snowflake", title: "Winter", description: "Cold season"),
        PhotoItem(id: 10, color: .mint, icon: "wind", title: "Breeze", description: "Gentle wind"),
        PhotoItem(id: 11, color: .teal, icon: "drop.fill", title: "Water", description: "Ocean waves"),
        PhotoItem(id: 12, color: .brown, icon: "mountain.2.fill", title: "Mountain", description: "Peak adventure"),
        PhotoItem(id: 13, color: .red, icon: "flame.fill", title: "Fire", description: "Hot and bright"),
        PhotoItem(id: 14, color: .orange, icon: "trophy.fill", title: "Victory", description: "Achievement"),
        PhotoItem(id: 15, color: .yellow, icon: "sparkles", title: "Magic", description: "Special moments"),
        PhotoItem(id: 16, color: .purple, icon: "music.note", title: "Music", description: "Harmonious melody"),
        PhotoItem(id: 17, color: .blue, icon: "airplane", title: "Travel", description: "Adventure awaits"),
        PhotoItem(id: 18, color: .green, icon: "figure.run", title: "Fitness", description: "Stay active"),
    ]
    
    // Thumbnail width + spacing
    let thumbnailWidth: CGFloat = 60
    let thumbnailSpacing: CGFloat = 12
    
    var itemWidth: CGFloat {
        thumbnailWidth + thumbnailSpacing
    }
    
    // Calculate selected index based on scroll position
    var selectedIndex: Int {
        let index = Int(round(scrollOffset / itemWidth))
        return max(0, min(photos.count - 1, index))
    }
    
    var currentPhoto: PhotoItem {
        photos[selectedIndex]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Main photo display area
                ZStack {
                    // Background gradient
                    LinearGradient(
                        colors: [currentPhoto.color.opacity(0.3), currentPhoto.color.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    // Photo content
                    VStack(spacing: 20) {
                        // Large icon representing the photo
                        Image(systemName: currentPhoto.icon)
                            .font(.system(size: 120))
                            .foregroundStyle(currentPhoto.color)
                            .shadow(color: currentPhoto.color.opacity(0.3), radius: 20)
                            .scaleEffect(isDragging ? 0.95 : 1.0)
                            .animation(.spring(response: 0.3), value: isDragging)
                        
                        // Photo title
                        Text(currentPhoto.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        // Photo description
                        Text(currentPhoto.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        // Photo counter
                        Text("\(selectedIndex + 1) of \(photos.count)")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(.ultraThinMaterial)
                            )
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id(selectedIndex) // Force view update
                
                // Scrubber section with fixed center selector
                ZStack {
                    // Background
                    Color(.systemGray6)
                    
                    VStack(spacing: 0) {
                        Spacer()
                        
                        // Scrubber container
                        ZStack {
                            // Scrollable thumbnails
                            ScrollViewReader { proxy in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: thumbnailSpacing) {
                                        // Leading spacer to center first item
                                        Color.clear
                                            .frame(width: (geometry.size.width - thumbnailWidth) / 2)
                                        
                                        ForEach(Array(photos.enumerated()), id: \.element.id) { index, photo in
                                            ThumbnailView(
                                                photo: photo,
                                                isSelected: selectedIndex == index,
                                                isCenterItem: selectedIndex == index
                                            )
                                            .frame(width: thumbnailWidth, height: thumbnailWidth)
                                            .id(index)
                                        }
                                        
                                        // Trailing spacer to center last item
                                        Color.clear
                                            .frame(width: (geometry.size.width - thumbnailWidth) / 2)
                                    }
                                    .background(
                                        GeometryReader { scrollGeometry in
                                            Color.clear
                                                .preference(
                                                    key: ScrollOffsetPreferenceKey.self,
                                                    value: scrollGeometry.frame(in: .named("scrollView")).minX
                                                )
                                        }
                                    )
                                }
                                .coordinateSpace(name: "scrollView")
                                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                                    let centerOffset = (geometry.size.width - thumbnailWidth) / 2
                                    scrollOffset = -(value + centerOffset)
                                }
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { _ in
                                            isDragging = true
                                        }
                                        .onEnded { _ in
                                            isDragging = false
                                        }
                                )
                            }
                            .frame(height: 100)
                            
                            // Fixed center selector indicator
                            VStack {
                                Rectangle()
                                    .fill(currentPhoto.color)
                                    .frame(width: 3, height: 30)
                                
                                Spacer()
                                
                                Rectangle()
                                    .fill(currentPhoto.color)
                                    .frame(width: 3, height: 30)
                            }
                            .frame(width: thumbnailWidth + 8, height: 100)
                            .allowsHitTesting(false) // Don't block scrolling
                        }
                        
                        Spacer()
                    }
                }
                .frame(height: 140)
            }
            .navigationTitle("Photos")
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
                    title: "Photo Scrubber",
                    content: ProjectInfoContent.photoScrubber
                )
            }
        }
    }
}


// MARK: - Scroll Offset Preference Key

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Thumbnail View

struct ThumbnailView: View {
    let photo: PhotoItem
    let isSelected: Bool
    let isCenterItem: Bool
    
    var body: some View {
        ZStack {
            // Thumbnail container
            RoundedRectangle(cornerRadius: 12)
                .fill(photo.color.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(
                            Color.clear,
                            lineWidth: 0
                        )
                )
            
            // Thumbnail icon
            Image(systemName: photo.icon)
                .font(.system(size: 28))
                .foregroundStyle(photo.color)
        }
        .opacity(isSelected ? 1.0 : 0.5)
        .scaleEffect(isSelected ? 1.0 : 0.85)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

// MARK: - Photo Item Model

struct PhotoItem: Identifiable {
    let id: Int
    let color: Color
    let icon: String
    let title: String
    let description: String
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PhotoScrubberView()
    }
}

