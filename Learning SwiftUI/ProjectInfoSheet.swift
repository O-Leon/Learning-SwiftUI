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
    static let photoScrubber = ProjectInfo(
        overview: "An interactive photo gallery with a scrubber interface inspired by the Apple Photos app. Features a horizontal thumbnail strip with smooth scrolling, tap-to-select functionality, and navigation controls. Displays a large preview of the selected photo with animated transitions.",
        features: [
            "Horizontal scrollable thumbnail strip",
            "Tap any thumbnail to view full preview",
            "Auto-centering of selected thumbnail",
            "Progress indicator bar showing position in gallery",
            "Previous/Next navigation buttons",
            "Dynamic color theming based on selected photo",
            "Smooth spring animations throughout",
            "Visual feedback with scale and shadow effects",
            "Photo counter display",
            "Gradient background matching photo colors",
            "12 sample photos with unique themes"
        ],
        uiComponents: [
            UIComponent(
                term: "ScrollViewReader",
                definition: "A view that provides programmatic scrolling to specific items in a ScrollView using proxy.scrollTo()."
            ),
            UIComponent(
                term: "ScrollView (Horizontal)",
                definition: "A scrollable container that displays content horizontally with showsIndicators parameter to control scroll bar visibility."
            ),
            UIComponent(
                term: "GeometryReader",
                definition: "A container view that gives access to its own size and coordinate space, useful for proportional layouts."
            ),
            UIComponent(
                term: "ZStack",
                definition: "Depth Stack - overlays views on top of each other for layering effects."
            ),
            UIComponent(
                term: "LinearGradient",
                definition: "A gradient that transitions colors along a straight line between start and end points."
            ),
            UIComponent(
                term: "Capsule",
                definition: "A rounded shape with circular ends, commonly used for progress bars and pills."
            ),
            UIComponent(
                term: ".ultraThinMaterial",
                definition: "A material blur effect that creates a translucent frosted glass appearance."
            ),
            UIComponent(
                term: ".simultaneousGesture()",
                definition: "Attaches a gesture that can recognize simultaneously with child gestures."
            ),
            UIComponent(
                term: "DragGesture",
                definition: "A gesture that recognizes dragging motion with minimum distance threshold."
            ),
            UIComponent(
                term: ".onChange() modifier",
                definition: "Executes code when a specific value changes, providing old and new values."
            ),
            UIComponent(
                term: ".shadow() modifier",
                definition: "Adds a shadow effect with configurable color, radius, and offset."
            ),
            UIComponent(
                term: "Array.enumerated()",
                definition: "Returns a sequence of index-element pairs for tracking position in arrays."
            )
        ],
        technicalSpecs: [
            TechnicalSpec(
                term: "State Management",
                value: "selectedIndex (Int), isDragging (Bool) - Track current photo and drag state"
            ),
            TechnicalSpec(
                term: "Data Model",
                value: "PhotoItem struct with id, color, icon, title, description - Identifiable protocol"
            ),
            TechnicalSpec(
                term: "Spring Animation",
                value: "response: 0.4, dampingFraction: 0.7 - Balanced bounce for selections"
            ),
            TechnicalSpec(
                term: "Quick Response Animation",
                value: "response: 0.3 - Fast spring for immediate feedback on drag state"
            ),
            TechnicalSpec(
                term: "Thumbnail Size",
                value: "60pt × 60pt with 12pt corner radius"
            ),
            TechnicalSpec(
                term: "Thumbnail Spacing",
                value: "12pt between thumbnails for comfortable scrolling"
            ),
            TechnicalSpec(
                term: "Selection Border",
                value: "3pt stroke in photo's color, scales to 1.1x with shadow"
            ),
            TechnicalSpec(
                term: "Progress Bar Height",
                value: "4pt capsule with dynamic width based on position"
            ),
            TechnicalSpec(
                term: "Navigation Buttons",
                value: "44pt chevron.circle.fill icons with disabled state styling"
            ),
            TechnicalSpec(
                term: "Main Icon Size",
                value: "120pt SF Symbol with color-matched shadow"
            ),
            TechnicalSpec(
                term: "ScrollTo Anchor",
                value: ".center - Centers selected thumbnail in visible area"
            ),
            TechnicalSpec(
                term: "Material Style",
                value: ".ultraThinMaterial for scrubber background - platform-adaptive blur"
            ),
            TechnicalSpec(
                term: "Dynamic Theming",
                value: "Colors adapt to selected photo for cohesive visual experience"
            ),
            TechnicalSpec(
                term: "Drag Detection",
                value: "minimumDistance: 0 for immediate drag state change"
            ),
            TechnicalSpec(
                term: "Selection Indicator",
                value: "6pt circle below thumbnail with scale+opacity transition"
            )
        ],
        learningPoints: [
            "Using ScrollViewReader for programmatic scrolling",
            "Implementing tap-to-select in horizontal ScrollView",
            "GeometryReader for proportional width calculations",
            "Creating progress bars with dynamic width",
            "Simultaneous gesture recognition",
            "DragGesture for touch state tracking",
            ".onChange modifier for reactive updates",
            "Auto-centering selected items in ScrollView",
            "Dynamic UI theming based on selected content",
            "Material effects for modern glass morphism",
            "Disabled button states with visual feedback",
            "Array enumeration for index tracking",
            "Combining scale effects with shadows",
            "Creating scrubber-style interfaces",
            "Smooth transitions between gallery items"
        ]
    )
    
    static let animatedStrokeButton = ProjectInfo(
        overview: "A custom button component featuring an animated border gradient that continuously rotates around the button. The gradient uses angular colors that create a neon-like glowing effect, perfect for call-to-action buttons.",
        features: [
            "Continuously rotating gradient border",
            "Custom button with black background",
            "Angular gradient with blue and orange colors",
            "Tap counter to demonstrate interaction",
            "Linear animation that never stops",
            "Smooth 3-second rotation cycle"
        ],
        uiComponents: [
            UIComponent(
                term: "Button",
                definition: "Interactive control that triggers an action when tapped."
            ),
            UIComponent(
                term: "AngularGradient",
                definition: "A gradient that sweeps colors in a circular pattern around a center point, defined by start and end angles."
            ),
            UIComponent(
                term: "RoundedRectangle",
                definition: "A rectangular shape with rounded corners, specified by cornerRadius parameter."
            ),
            UIComponent(
                term: ".stroke() modifier",
                definition: "Draws the outline of a shape with specified style and line width."
            ),
            UIComponent(
                term: ".fill() modifier",
                definition: "Fills a shape with a color, gradient, or material."
            ),
            UIComponent(
                term: "VStack",
                definition: "Vertical Stack - arranges child views in a vertical line with configurable spacing."
            ),
            UIComponent(
                term: ".onAppear() modifier",
                definition: "Executes code when the view appears on screen, ideal for starting animations."
            )
        ],
        technicalSpecs: [
            TechnicalSpec(
                term: "State Management",
                value: "@State private var animationAmount - Tracks rotation angle for continuous animation"
            ),
            TechnicalSpec(
                term: "Animation Type",
                value: ".linear(duration: 3) - Constant speed rotation with no acceleration/deceleration"
            ),
            TechnicalSpec(
                term: "Animation Loop",
                value: "repeatForever(autoreverses: false) - Continuous rotation in one direction"
            ),
            TechnicalSpec(
                term: "Gradient Type",
                value: "AngularGradient with startAngle and endAngle controlled by animation state"
            ),
            TechnicalSpec(
                term: "Gradient Colors",
                value: "[.blue, .orange, .blue] - Creates smooth color transition around the circle"
            ),
            TechnicalSpec(
                term: "Stroke Width",
                value: "5pt border thickness for visible gradient effect"
            ),
            TechnicalSpec(
                term: "Corner Radius",
                value: "32pt for pill-shaped button appearance"
            ),
            TechnicalSpec(
                term: "Padding",
                value: "Horizontal: 32pt, Vertical: 16pt for comfortable tap target"
            ),
            TechnicalSpec(
                term: "Rotation Range",
                value: "0° to 360° - Full circle rotation"
            ),
            TechnicalSpec(
                term: "Text Color",
                value: ".white foreground on black background for high contrast"
            )
        ],
        learningPoints: [
            "Creating custom button components",
            "Implementing AngularGradient for circular effects",
            "Using .onAppear for animation initialization",
            "Continuous animations with repeatForever",
            "Combining .fill() and .stroke() modifiers",
            "Managing animation state with @State",
            "Linear timing curves for constant motion",
            "Closure-based button actions",
            "Custom button styling techniques"
        ]
    )
    
    static let animationsPlayground = ProjectInfo(
        overview: "An interactive playground for experimenting with different SwiftUI animation types. Users can apply scale, rotation, offset transformations, and shape morphing to a shape, each with different animation curves to understand their effects.",
        features: [
            "Four independent animation controls",
            "Spring animation for scaling",
            "EaseInOut animation for rotation",
            "Bouncy animation for movement",
            "Smooth morph animation between shapes",
            "Dynamic button color change based on morph state",
            "Reset button to return to initial state",
            "Visual feedback with prominent buttons",
            "Real-time animation preview"
        ],
        uiComponents: [
            UIComponent(
                term: "Button",
                definition: "Interactive control that triggers an action when tapped."
            ),
            UIComponent(
                term: "RoundedRectangle",
                definition: "A rectangular shape with rounded corners, specified by cornerRadius parameter."
            ),
            UIComponent(
                term: "Circle",
                definition: "A perfectly circular shape that adapts to its frame size."
            ),
            UIComponent(
                term: "ZStack",
                definition: "Depth Stack - overlays views on top of each other, useful for layering and transitioning between views."
            ),
            UIComponent(
                term: "VStack",
                definition: "Vertical Stack - arranges child views in a vertical line with configurable spacing."
            ),
            UIComponent(
                term: ".scaleEffect() modifier",
                definition: "Scales a view up or down by a specified factor, anchored at center by default."
            ),
            UIComponent(
                term: ".rotationEffect() modifier",
                definition: "Rotates a view by specified angle (in degrees or radians)."
            ),
            UIComponent(
                term: ".offset() modifier",
                definition: "Moves a view from its natural position by x and/or y points."
            ),
            UIComponent(
                term: ".transition() modifier",
                definition: "Defines how a view appears and disappears when added/removed from the view hierarchy."
            ),
            UIComponent(
                term: ".buttonStyle() modifier",
                definition: "Applies a predefined or custom style to a button."
            ),
            UIComponent(
                term: ".tint() modifier",
                definition: "Sets the tint color for interactive elements like buttons."
            )
        ],
        technicalSpecs: [
            TechnicalSpec(
                term: "State Management",
                value: "Four @State properties: scale (CGFloat), rotation (Double), offset (CGFloat), isMorphed (Bool)"
            ),
            TechnicalSpec(
                term: "Spring Animation",
                value: "response: 0.6, dampingFraction: 0.6 - Natural bouncy feel with medium damping"
            ),
            TechnicalSpec(
                term: "EaseInOut Animation",
                value: "duration: 1.0 second - Smooth start and end with faster middle"
            ),
            TechnicalSpec(
                term: "Bouncy Animation",
                value: "Built-in .bouncy curve - Extra spring with overshoot effect"
            ),
            TechnicalSpec(
                term: "Smooth Animation",
                value: "duration: 0.8 seconds - Fluid morph transition with no overshoot, ideal for shape changes"
            ),
            TechnicalSpec(
                term: "Morph Transition",
                value: ".scale.combined(with: .opacity) - Shapes crossfade and scale simultaneously for smooth morph effect"
            ),
            TechnicalSpec(
                term: "Conditional Rendering",
                value: "if-else within ZStack to switch between RoundedRectangle and Circle shapes"
            ),
            TechnicalSpec(
                term: "Scale Range",
                value: "1.0 to 1.5 (50% size increase)"
            ),
            TechnicalSpec(
                term: "Rotation Increment",
                value: "+360° per tap - Full rotation, accumulates with each press"
            ),
            TechnicalSpec(
                term: "Offset Range",
                value: "0pt to 100pt vertical movement"
            ),
            TechnicalSpec(
                term: "Button Styles",
                value: ".borderedProminent for actions, .bordered for reset"
            ),
            TechnicalSpec(
                term: "Dynamic Tint",
                value: "Button tint changes from blue to purple based on morph state"
            ),
            TechnicalSpec(
                term: "Shape Size",
                value: "100pt × 100pt - consistent size for both shapes"
            ),
            TechnicalSpec(
                term: "Shape Corner Radius",
                value: "RoundedRectangle: 20pt, Circle: naturally rounded"
            ),
            TechnicalSpec(
                term: "Layout Spacing",
                value: "40pt between shape and controls, 20pt between buttons"
            )
        ],
        learningPoints: [
            "Understanding different animation curves",
            "withAnimation wrapper for explicit animations",
            "Spring physics parameters (response, damping)",
            "Difference between easeInOut, bouncy, and smooth",
            "Shape morphing with conditional rendering",
            "Combining transitions with .combined(with:)",
            "ZStack for view switching",
            "Accumulating transformations (rotation)",
            "Toggle states vs accumulating values",
            "Multiple independent @State properties",
            "Button styling variations",
            "Dynamic tint colors based on state",
            "Combining multiple modifiers on one view",
            "Animation timing and duration control",
            "Creating seamless shape transitions"
        ]
    )
    
    static let colorGradient = ProjectInfo(
        overview: "An interactive view demonstrating color gradient manipulation in SwiftUI. Users can switch between different color schemes and see smooth animated transitions applied to a linear gradient.",
        features: [
            "Interactive color scheme buttons",
            "Real-time gradient preview",
            "Smooth animated color transitions",
            "Three preset color palettes (Blues, Warm, Natural)",
            "LinearGradient with diagonal flow",
            "Responsive layout design"
        ],
        uiComponents: [
            UIComponent(
                term: "LinearGradient",
                definition: "A gradient that transitions colors along a straight line between two points (startPoint and endPoint)."
            ),
            UIComponent(
                term: "RoundedRectangle",
                definition: "A rectangular shape with rounded corners, specified by cornerRadius parameter."
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
                term: "Button",
                definition: "Interactive control that triggers an action when tapped."
            ),
            UIComponent(
                term: ".fill() modifier",
                definition: "Fills a shape with a color, gradient, or material."
            ),
            UIComponent(
                term: ".frame() modifier",
                definition: "Sets the size of a view with width and/or height parameters."
            ),
            UIComponent(
                term: ".padding() modifier",
                definition: "Adds space around a view's edges. Can be uniform or directional."
            )
        ],
        technicalSpecs: [
            TechnicalSpec(
                term: "State Management",
                value: "@State private var gradientColors - Array of Color values that updates the gradient"
            ),
            TechnicalSpec(
                term: "Animation Type",
                value: "withAnimation { } wrapper provides default easeInOut animation for state changes"
            ),
            TechnicalSpec(
                term: "Gradient Direction",
                value: "startPoint: .topLeading, endPoint: .bottomTrailing creates diagonal flow"
            ),
            TechnicalSpec(
                term: "Corner Radius",
                value: "20pt rounded corners for the gradient container"
            ),
            TechnicalSpec(
                term: "Layout Spacing",
                value: "VStack: 30pt, HStack: 15pt between buttons"
            ),
            TechnicalSpec(
                term: "Button Style",
                value: ".bordered - System style with light background and rounded appearance"
            ),
            TechnicalSpec(
                term: "Control Size",
                value: ".small - Compact button size for secondary actions"
            ),
            TechnicalSpec(
                term: "Container Height",
                value: "200pt fixed height for gradient display area"
            ),
            TechnicalSpec(
                term: "Color Arrays",
                value: "Blues: [.blue, .cyan, .mint], Warm: [.orange, .red, .pink], Natural: [.green, .mint, .teal]"
            )
        ],
        learningPoints: [
            "Creating linear gradients with multiple colors",
            "Animating color transitions with withAnimation",
            "Using @State to manage dynamic color arrays",
            "Applying gradients to shapes with .fill() modifier",
            "Working with UnitPoint for gradient directions",
            "Button styling with system button styles",
            "Closure-based action handlers",
            "Layout composition with stacks"
        ]
    )
    
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
