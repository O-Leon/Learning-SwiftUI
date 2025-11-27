//
//  ProjectsListView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Vista principal que muestra la lista de todos los mini proyectos
struct ProjectsListView: View {
    let projects: [MiniProject] = [
        MiniProject(
            title: "Animated Stroke Button",
            description: "Botón con borde animado usando gradientes",
            icon: "sparkles.rectangle.stack"
        ) {
            AnimatedStrokeButtonView()
        },
        MiniProject(
            title: "Gradientes de Color",
            description: "Experimenta con diferentes gradientes y colores",
            icon: "paintpalette.fill"
        ) {
            ColorGradientView()
        },
        MiniProject(
            title: "Playground de Animaciones",
            description: "Prueba diferentes tipos de animaciones SwiftUI",
            icon: "wand.and.stars"
        ) {
            AnimationsPlaygroundView()
        },
        // Agrega más proyectos aquí
    ]
    
    var body: some View {
        NavigationStack {
            List(projects) { project in
                NavigationLink(destination: project.view) {
                    ProjectRow(project: project)
                }
            }
            .navigationTitle("SwiftUI Mini Proyectos")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

/// Vista de fila para cada proyecto en la lista
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
