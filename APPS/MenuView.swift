//
//  MenuView.swift
//  APPS
//
//  Created by Ulises Martínez on 18/06/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
            VStack{
            
                    
                // Envuelve el NavigationLink en un Button para tener más control sobre su estilo.
                    Button(action: {
                        // Acción a realizar cuando se presiona el botón.
                        // En este caso, activa el NavigationLink.
                    }) {
                        // Contenido del botón.
                        NavigationLink(destination: IMCView()) {
                            Text("IMC Calculadora")
                                // Aplica estilos directamente al texto.
                                .padding() // Añade padding alrededor del texto.
                                .font(.title)
                                .bold()
                                .background(.backgrounComponent) // Fondo azul.
                               .foregroundColor(.white) // Texto blanco.
                               .cornerRadius(16) // Borde redondeado.
                               .shadow(radius: 8) // Sombra con radio de 8.
                               
                        }
                    }
                    // Ajusta el padding del botón.
                   .padding()
                
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .background(.backgroundApp)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text("Menú Apps")
                            .foregroundColor(.white)
                            .bold()
                            .font(.largeTitle)
                    }
                }

        }
    }
}

#Preview {
    MenuView()
}
