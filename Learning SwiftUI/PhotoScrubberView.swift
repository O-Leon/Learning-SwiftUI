//
//  PhotoScrubberView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/27/25.
//

import SwiftUI

/// Mini Project 5: Photo Scrubber with Thumbnail Gallery
struct PhotoScrubberView: View {
    @State private var selectedIndex: Int = 0
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
    ]
    
    var currentPhoto: PhotoItem {
        photos[selectedIndex]
    }
    
    var body: some View {
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
            
            // Scrubber section
            VStack(spacing: 16) {
                // Progress indicator
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background track
                        Capsule()
                            .fill(Color(.systemGray5))
                            .frame(height: 4)
                        
                        // Progress track
                        Capsule()
                            .fill(currentPhoto.color)
                            .frame(width: geometry.size.width * CGFloat(selectedIndex + 1) / CGFloat(photos.count), height: 4)
                            .animation(.spring(response: 0.3), value: selectedIndex)
                    }
                }
                .frame(height: 4)
                .padding(.horizontal)
                
                // Thumbnail scrubber
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(photos.enumerated()), id: \.element.id) { index, photo in
                                ThumbnailView(
                                    photo: photo,
                                    isSelected: selectedIndex == index
                                )
                                .id(index)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                        selectedIndex = index
                                    }
                                    
                                    // Scroll to center the selected thumbnail
                                    withAnimation {
                                        proxy.scrollTo(index, anchor: .center)
                                    }
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
                        }
                        .padding(.horizontal)
                    }
                    .onChange(of: selectedIndex) { oldValue, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
                .frame(height: 80)
                
                // Navigation controls
                HStack(spacing: 40) {
                    Button {
                        if selectedIndex > 0 {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                selectedIndex -= 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(selectedIndex > 0 ? currentPhoto.color : .gray.opacity(0.3))
                    }
                    .disabled(selectedIndex == 0)
                    
                    Button {
                        if selectedIndex < photos.count - 1 {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                selectedIndex += 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(selectedIndex < photos.count - 1 ? currentPhoto.color : .gray.opacity(0.3))
                    }
                    .disabled(selectedIndex == photos.count - 1)
                }
                .padding(.bottom, 8)
            }
            .padding(.vertical, 20)
            .background(.ultraThinMaterial)
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

// MARK: - Thumbnail View

struct ThumbnailView: View {
    let photo: PhotoItem
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Thumbnail container
                RoundedRectangle(cornerRadius: 12)
                    .fill(photo.color.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                isSelected ? photo.color : Color.clear,
                                lineWidth: 3
                            )
                    )
                
                // Thumbnail icon
                Image(systemName: photo.icon)
                    .font(.system(size: 28))
                    .foregroundStyle(photo.color)
            }
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .shadow(color: isSelected ? photo.color.opacity(0.5) : .clear, radius: 8)
            
            // Selection indicator
            if isSelected {
                Circle()
                    .fill(photo.color)
                    .frame(width: 6, height: 6)
                    .transition(.scale.combined(with: .opacity))
            }
        }
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
