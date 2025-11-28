//
//  ProjectInfoSheet.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/27/25.
//

import SwiftUI

/// Reusable sheet to display project information and technical specifications
struct ProjectInfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let content: ProjectInfo
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Overview Section
                    InfoSection(title: "Overview", icon: "doc.text.fill") {
                        Text(content.overview)
                            .font(.body)
                    }
                    
                    // Key Features Section
                    InfoSection(title: "Key Features", icon: "star.fill") {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(content.features, id: \.self) { feature in
                                FeatureRow(text: feature)
                            }
                        }
                    }
                    
                    // UI Components Section
                    InfoSection(title: "UI Components", icon: "square.stack.3d.up.fill") {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(content.uiComponents, id: \.term) { component in
                                ComponentRow(component: component)
                            }
                        }
                    }
                    
                    // Technical Specifications Section
                    InfoSection(title: "Technical Specifications", icon: "gearshape.2.fill") {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(content.technicalSpecs, id: \.term) { spec in
                                SpecRow(spec: spec)
                            }
                        }
                    }
                    
                    // Learning Points Section
                    if !content.learningPoints.isEmpty {
                        InfoSection(title: "What You'll Learn", icon: "graduationcap.fill") {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(content.learningPoints, id: \.self) { point in
                                    FeatureRow(text: point)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Info Section Container

struct InfoSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                    .font(.title3)
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            content
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Feature Row

struct FeatureRow: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .font(.body)
            
            Text(text)
                .font(.body)
        }
    }
}

// MARK: - Component Row

struct ComponentRow: View {
    let component: UIComponent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(component.term)
                .font(.headline)
                .foregroundStyle(.blue)
            
            Text(component.definition)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Spec Row

struct SpecRow: View {
    let spec: TechnicalSpec
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "chevron.right.circle.fill")
                .foregroundStyle(.orange)
                .font(.body)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(spec.term)
                    .font(.headline)
                
                Text(spec.value)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Data Models

struct ProjectInfo {
    let overview: String
    let features: [String]
    let uiComponents: [UIComponent]
    let technicalSpecs: [TechnicalSpec]
    let learningPoints: [String]
}

struct UIComponent {
    let term: String
    let definition: String
}

struct TechnicalSpec {
    let term: String
    let value: String
}

// MARK: - Project Info Content

enum ProjectInfoContent {
    static let iconScrollBar = ProjectInfo(
        overview: "A horizontal scrollable bar that displays a collection of selectable icons. When an icon is tapped, it displays detailed information in a larger view above with smooth animations and transitions.",
        features: [
            "Horizontal scrollable icon bar with 15 themed icons",
            "Interactive selection with visual feedback",
            "Large icon display with pulsating animation",
            "Color-coded icons with unique descriptions",
            "Empty state with helpful instructions",
            "Smooth spring animations on selection"
        ],
        uiComponents: [
            UIComponent(
                term: "ScrollView (Horizontal)",
                definition: "A scrollable container that displays content horizontally. Set with `.horizontal` parameter and `showsIndicators: false` to hide scroll indicators."
            ),
            UIComponent(
                term: "HStack",
                definition: "Horizontal Stack - arranges child views in a horizontal line with configurable spacing."
            ),
            UIComponent(
                term: "VStack",
                definition: "Vertical Stack - arranges child views in a vertical line with configurable spacing."
            ),
            UIComponent(
                term: "ZStack",
                definition: "Depth Stack - overlays views on top of each other, useful for layering effects."
            ),
            UIComponent(
                term: "NavigationStack",
                definition: "Container for managing navigation hierarchy and navigation bar elements."
            ),
            UIComponent(
                term: "Toolbar",
                definition: "Container for toolbar items, placed in navigation bar or other locations."
            ),
            UIComponent(
                term: "Sheet",
                definition: "Modal presentation that slides up from the bottom, commonly used for secondary content or forms."
            ),
            UIComponent(
                term: "Divider",
                definition: "Visual separator line between content sections."
            ),
            UIComponent(
                term: "ForEach",
                definition: "Dynamic view generator that creates views from a collection of data."
            )
        ],
        technicalSpecs: [
            TechnicalSpec(
                term: "State Management",
                value: "@State private var selectedIcon - Local state property that triggers view updates when changed"
            ),
            TechnicalSpec(
                term: "Data Model",
                value: "IconItem struct conforming to Identifiable and Equatable protocols"
            ),
            TechnicalSpec(
                term: "Animation Type",
                value: "Spring animation with response: 0.3, dampingFraction: 0.7 for natural bouncy feel"
            ),
            TechnicalSpec(
                term: "Transition Effects",
                value: "Asymmetric transition - .scale + .opacity for insertion, .opacity for removal"
            ),
            TechnicalSpec(
                term: "Loop Animation",
                value: "repeatForever(autoreverses: true) with easeInOut for continuous pulsating effect"
            ),
            TechnicalSpec(
                term: "Color System",
                value: "Dynamic Color with semantic colors (systemGray6, systemBackground) for dark mode support"
            ),
            TechnicalSpec(
                term: "Layout Spacing",
                value: "Icon buttons: 16pt spacing, sections: 12-24pt vertical spacing"
            ),
            TechnicalSpec(
                term: "Button Style",
                value: ".plain button style to allow custom styling without default button appearance"
            ),
            TechnicalSpec(
                term: "Corner Radius",
                value: "16pt for icon buttons, 12pt for info sections - creates consistent rounded appearance"
            ),
            TechnicalSpec(
                term: "SF Symbols",
                value: "Apple's icon system - scalable vector icons integrated with system fonts"
            )
        ],
        learningPoints: [
            "Horizontal scrolling with ScrollView",
            "State management with @State property wrapper",
            "Conditional view rendering with if-let",
            "Spring animations for natural movement",
            "Asymmetric view transitions",
            "ForEach for dynamic view generation",
            "Button customization with .plain style",
            "Scale effects for interactive feedback",
            "Continuous animations with repeatForever",
            "Sheet presentation for modal content",
            "Toolbar configuration in NavigationStack",
            "Semantic colors for dark mode support"
        ]
    )
}

// MARK: - Preview

#Preview {
    ProjectInfoSheet(
        title: "Scrollable Icon Bar",
        content: ProjectInfoContent.iconScrollBar
    )
}
