//
//  DialogoCustom.swift
//  APPS
//
//  Created by Ulises Martínez on 04/07/24.
//

import SwiftUI
/// Un componente reutilizable para mostrar diálogos personalizados en la aplicación.
///
/// Este componente permite mostrar un diálogo con contenido personalizado, ofreciendo opciones para cerrar el diálogo desde dentro o desde fuera del área segura de la pantalla.
///
/// - Parameters:
///   - `cerrarDialogo`: Una closure que se invoca cuando se cierra el diálogo.
///   - `onDismissOutside`: Un booleano que determina si el diálogo debe cerrarse cuando se toca fuera de él.
///   - `contenido`: El contenido personalizado que se mostrará dentro del diálogo.
struct DialogoCustom<Content:View>: View {
    /// Closure que se invoca cuando se cierra el diálogo.
    let cerrarDialogo:() -> Void
    /// Booleano que determina si el diálogo debe cerrarse cuando se toca fuera de él.
    let onDismissOutside:Bool
    /// El contenido personalizado que se mostrará dentro del diálogo.
    let contenido:Content
    
    /// Implementación de la vista.
    var body: some View {
        ZStack{
            // Fondo semi-transparente que cubre toda la pantalla.
            Rectangle().fill(.gray.opacity(0.7))
                .ignoresSafeArea()
                .onTapGesture {
                    // Cierra el diálogo si onDismissOutside es verdadero.
                    if onDismissOutside {
                        
                        withAnimation{
                            cerrarDialogo()
                        }
                    }
                }
            // Contenido del diálogo con un fondo blanco y bordes redondeados.
            contenido.frame(width: UIScreen.main.bounds.size.width-100, height: 300)
                .padding()
                .background(.white)
                .cornerRadius(16)
                .overlay(alignment: .topTrailing){
                    // Botón para cerrar el diálogo.
                    Button(action: { withAnimation{ cerrarDialogo() } } , label:{ Image(systemName: "xmark.circle")})
                        .foregroundColor(.gray)
                        .padding(14)
                }
        }.ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height, alignment: .center)
    }
}

