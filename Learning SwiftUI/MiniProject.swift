//
//  MiniProject.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Modelo que representa un mini proyecto individual
struct MiniProject: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let view: AnyView
    
    init<V: View>(title: String, description: String, icon: String, @ViewBuilder view: () -> V) {
        self.title = title
        self.description = description
        self.icon = icon
        self.view = AnyView(view())
    }
}
