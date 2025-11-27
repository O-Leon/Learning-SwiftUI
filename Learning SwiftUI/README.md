# SwiftUI Mini Proyectos

## 📱 Estructura del Proyecto

Este proyecto está organizado como una galería de mini proyectos de SwiftUI para practicar y experimentar.

### Archivos Principales

- **ContentView.swift**: Vista raíz de la aplicación
- **ProjectsListView.swift**: Lista navegable de todos los mini proyectos
- **MiniProject.swift**: Modelo de datos para cada proyecto

### Mini Proyectos

Cada mini proyecto tiene su propio archivo:

1. **AnimatedStrokeButtonView.swift** - Botón con borde animado
2. **ColorGradientView.swift** - Experimentos con gradientes
3. **AnimationsPlaygroundView.swift** - Playground de animaciones

## ➕ Cómo Agregar un Nuevo Mini Proyecto

### Paso 1: Crear un nuevo archivo Swift

Crea un archivo nuevo (File > New > File... > Swift File) con el nombre de tu proyecto, por ejemplo: `MyNewProjectView.swift`

### Paso 2: Estructura básica de la vista

```swift
//
//  MyNewProjectView.swift
//  Learning SwiftUI
//
//  Created by Omer on 11/26/25.
//

import SwiftUI

/// Mini Proyecto X: Descripción breve
struct MyNewProjectView: View {
    // Estados y propiedades
    @State private var myState = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Mi Nuevo Proyecto")
                .font(.title)
            
            // Tu código aquí
            
        }
        .padding()
        .navigationTitle("Mi Proyecto")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MyNewProjectView()
    }
}
```

### Paso 3: Agregar a la lista

En `ProjectsListView.swift`, agrega tu proyecto al array `projects`:

```swift
MiniProject(
    title: "Mi Nuevo Proyecto",
    description: "Descripción breve de lo que hace",
    icon: "star.fill"  // Cualquier SF Symbol
) {
    MyNewProjectView()
},
```

## 🎨 Iconos Recomendados (SF Symbols)

Algunos íconos útiles para tus proyectos:
- `star.fill`, `heart.fill`, `bolt.fill`
- `sparkles`, `wand.and.stars`
- `paintbrush.fill`, `paintpalette.fill`
- `slider.horizontal.3`, `dial.medium`
- `circle.grid.3x3.fill`, `square.grid.2x2.fill`
- `photo.fill`, `camera.fill`
- `play.circle.fill`, `pause.circle.fill`

## 📝 Tips

1. **Canvas Preview**: Usa `#Preview` para ver cambios en tiempo real
2. **NavigationStack**: Siempre incluye NavigationStack en tu preview
3. **Modularidad**: Mantén cada componente reutilizable en structs separados
4. **Estados**: Usa `@State` para valores que cambian dentro de la vista
5. **Comentarios**: Documenta tu código para recordar qué hace cada parte

## 🚀 Workflow Recomendado

1. Crea una nueva vista para tu experimento
2. Usa el Canvas para iterar rápidamente
3. Agrega la vista a la lista de proyectos
4. Prueba en tu teléfono para ver el resultado final
5. Itera y mejora

## 📚 Recursos

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [SF Symbols Browser](https://developer.apple.com/sf-symbols/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)

---

¡Diviértete aprendiendo SwiftUI! 🎉
