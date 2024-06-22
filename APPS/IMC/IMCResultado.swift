//
//  IMCResultado.swift
//  APPS
//
//  Created by Ulises Martínez on 21/06/24.
//

import SwiftUI

// Definición de la estructura IMCResultado que conforma a View
struct IMCResultado: View {
    // Propiedades para almacenar el peso y la altura del usuario
    let usuarioPeso:Double
    let usuarioAltura:Double
    
    // El cuerpo de la vista, que define cómo se muestra en la pantalla
    var body: some View {
        VStack{// Contenedor vertical para organizar los elementos
                        
            // Calcula el IMC y pasa el resultado a la vista de información
            let result = calculoIMC(peso: usuarioPeso, altura: usuarioAltura)
            InformationView(resultado: result)
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(.backgroundApp)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Resultado")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                }
                
            }

    }
}

// Función para calcular el IMC
func calculoIMC(peso:Double, altura:Double) -> Double{
    // Realiza el cálculo del IMC
    let result = peso/((altura/100)*(altura/100))
    return result
}

// Definición de la estructura InformationView que conforma a View
struct InformationView:View {
    // Propiedad para almacenar el resultado del IMC
    let resultado:Double
    // El cuerpo de la vista, que define cómo se muestra en la pantalla
    var body: some View {
        // Obtiene la descripción del resultado del IMC
        let informacion = getIMCResultado(resultado: resultado)
        
        VStack{// Contenedor vertical para organizar los elementos
            Spacer()// Espacio para centrar verticalmente
            // Muestra el título del resultado
            Text(informacion.0)
                .foregroundColor(informacion.2)
                .font(.system(size: 40))
                .bold()
            Spacer()// Espacio para centrar verticalmente

            // Muestra el valor numérico del IMC
            Text("\(resultado, specifier: "%.2f")")
                .font(.system(size: 80))
                .bold()
                .foregroundColor(.white)
                .padding(.vertical, 20)
            Spacer()// Espacio para centrar verticalmente

            // Muestra la descripción del resultado
            Text(informacion.1)
                .foregroundColor(.white)
                .font(.title2)
                .padding(.horizontal, 6)
            Spacer()// Espacio para centrar verticalmente
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgrounComponent)
            .cornerRadius(18)// Redondea las esquinas
            .padding(13) // Añade padding alrededor
            
    }
}

// Función para obtener la descripción del resultado del IMC
func getIMCResultado(resultado:Double) -> (String, String, Color){
    // Determina la categoría del resultado del IMC
    let titulo:String
    let descripcion:String
    let color:Color
    
    switch resultado{
    case 0.00..<20:
        titulo = "Peso bajo"
        descripcion = "Estás por debajo del peso recomendado"
        color = Color.yellow
    case 20..<25:
        titulo = "Normal"
        descripcion = "Estás en el peso recomendado"
        color = Color.green
    case 25..<30:
        titulo = "Sobrepeso"
        descripcion = "Estás por encima del peso recomendado"
        color = Color.orange
    case 30..<101:
        titulo = "Obesidad"
        descripcion = "Estás muy por encima del peso recomendado"
        color = Color.red
    default:
        titulo = "ERROR"
        descripcion = "Ha ocurrido un error"
        color = Color.indigo
    }
    
    return (titulo, descripcion, color)
}

#Preview {
    IMCResultado( usuarioPeso: 77, usuarioAltura: 177)
}
