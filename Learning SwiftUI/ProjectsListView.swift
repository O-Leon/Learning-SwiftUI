//
//  ProjectsListView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Main view displaying the list of all mini projects
struct ProjectsListView: View {
    let projects: [MiniProject] = [
        // Newest first
        MiniProject(
            title: "Photo Scrubber",
            description: "Horizontal photo gallery with thumbnail scrubber",
            icon: "photo.on.rectangle.angled"
        ) {
            PhotoScrubberView()
        },
        MiniProject(
            title: "Scrollable Icon Bar",
            description: "Horizontal scrollable bar with selectable icons",
            icon: "square.grid.3x3.fill"
        ) {
            IconScrollBarView()
        },
        MiniProject(
            title: "Animations Playground",
            description: "Test different types of SwiftUI animations",
            icon: "wand.and.stars"
        ) {
            AnimationsPlaygroundView()
        },
        MiniProject(
            title: "Color Gradients",
            description: "Experiment with different gradients and colors",
            icon: "paintpalette.fill"
        ) {
            ColorGradientView()
        },
        MiniProject(
            title: "Animated Stroke Button",
            description: "Button with animated border using gradients",
            icon: "sparkles.rectangle.stack"
        ) {
            AnimatedStrokeButtonView()
        },
        // Add more projects here
    ]
    
    var body: some View {
        NavigationStack {
            List(projects) { project in
                NavigationLink(destination: project.view) {
                    ProjectRow(project: project)
                }
            }
            .navigationTitle("SwiftUI Mini Projects")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

/// Row view for each project in the list
struct ProjectRow: View {
    let project: MiniProject
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: project.icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(project.title)
                    .font(.headline)
                
                Text(project.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ProjectsListView()
}
