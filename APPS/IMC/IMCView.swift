//
//  IMCView.swift
//  APPS
//
//  Created by Ulises Martínez on 18/06/24.
//

import SwiftUI
import UIKit


// Definimos una estructura llamada IMCView que conforma al protocolo View de SwiftUI.
struct IMCView: View {
    
  /*  init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    */
    
    // Inicializamos una variable de estado llamada 'gender' con valor inicial 0 (para representar género masculino).
    @State var gender:Int = 0
    @State var altura:Double = 150
    @State var edad:Int = 22
    @State var peso:Int = 80
    
    // Definimos el cuerpo de nuestra vista utilizando un VStack (contenedor vertical) que contiene un HStack (contenedor horizontal).
    var body: some View {
        
        VStack{
            // Dentro del HStack, colocamos dos botones de alternancia (ToggleButton) para seleccionar el género.
            HStack{
                ToggleButton(texto: "Hombre", imagenName: "male", genero: 0, selectedGenero: $gender)
                ToggleButton(texto: "Mujer", imagenName: "female", genero:1, selectedGenero: $gender)
                
            }
            
            HeightCalculator(selectedHeight: $altura)
            
            HStack{
                
                CounterButton(texto: "Edad", numero: $edad)
                CounterButton(texto: "Peso", numero: $peso)
            }
            
            IMCCalcularBoton(usuarioPeso: Double(peso), usuarioAltura: altura)
            
        
            // Establecemos un tamaño máximo infinito para nuestro contenedor principal.
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        // Aplicamos un fondo personalizado (.backgroundApp).
        .background(.backgroundApp)
        // Agregamos una barra de herramientas con un título principal.
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("IMC calculadora")
                    .foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
            }
            
        }
       // .navigationTitle("IMC calculadora")
      //  .navigationBarBackButtonHidden()
    }
}

// Definimos una estructura llamada ToggleButton que también conforma al protocolo View de SwiftUI.
struct ToggleButton:View {
    
    // Declaramos las propiedades necesarias para nuestro botón de alternancia.
    let texto:String
    let imagenName:String
    let genero:Int
    
    @Binding var selectedGenero:Int
    
    // Definimos el cuerpo de nuestro botón de alternancia.
    var body: some View {
        
        // Determinamos el color de fondo basado en si el botón está seleccionado o no.
        let color = if( genero == selectedGenero){
            Color.backgroundSelected
        }else{
            Color.backgrounComponent
        }
        
        // Creamos un botón que actualiza el valor de 'selectedGenero' cuando es presionado.
        Button(action:{
            selectedGenero = genero
        }) {
            VStack{
                // Mostramos una imagen y un texto dentro del botón.
                Image(imagenName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                InformationText(text: texto)
            }
            
        }
        // Establecemos un tamaño máximo infinito para nuestro botón.
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        // Aplicamos el color de fondo determinado anteriormente.
            .background(color)
    }
}

// Definimos una estructura llamada InformationText que conforma al protocolo View de SwiftUI.
struct InformationText:View {
    
    // Declaramos la propiedad de texto que será mostrada.
    let text:String
    
    // Definimos el cuerpo de nuestro componente de texto.
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.black)
    }
}

// Definimos una estructura llamada NumText que conforma al protocolo View de SwiftUI.
struct NumText:View {
    // Declaramos la propiedad de numero que será mostrada como cadena de texto.
    let numero: String
    var body: some View {
        // Definimos el cuerpo de nuestro componente de texto.
        Text(numero)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.white)
    }
}

// Definimos una estructura llamada TitleText que conforma al protocolo View de SwiftUI.
struct TitleText:View {
    // Declaramos la propiedad de texto que será mostrada.
    let text:String

    var body: some View {
        // Definimos el cuerpo de nuestro componente de texto.
        Text(text)
            .font(.title2)
            .foregroundColor(.black)

    }
}

// Definición de la estructura HeightCalculator que conforma a View
struct HeightCalculator:View {
    // Propiedad con Binding para actualizar la altura seleccionada desde otras vistas
    @Binding var selectedHeight: Double

    // El cuerpo de la vista, que define cómo se muestra en la pantalla
    var body: some View {
        VStack{// Contenedor vertical para organizar los elementos
            // Muestra un título "Altura"
            TitleText(text: "Altura")
            // Muestra el número actual de la altura seleccionada
            NumText(numero: "\(Int(selectedHeight)) cm")
            // Deslizador para ajustar la altura seleccionada entre 100cm y 220cm
            Slider(value: $selectedHeight, in:100...220, step: 1)
                .accentColor(.cyan)// Cambia el color del control deslizante a cian
                .padding(.horizontal, 16) // Añade padding horizontal alrededor del deslizador
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)// Define el tamaño máximo de la vista
            .background(.backgrounComponent)// Aplica un fondo específico
    }
}

// Definición de la estructura CounterButton que conforma a View
struct CounterButton:View {
    // Propiedades para almacenar el texto del botón y el valor del contador
    let texto:String
    @Binding var numero:Int
    
    // El cuerpo de la vista, que define cómo se muestra en la pantalla
    var body: some View {
        VStack{ // Contenedor vertical para organizar los elementos
            // Muestra el texto del botón
            TitleText(text: texto)
            // Muestra el valor actual del contador
            NumText(numero: String(numero))
            
            // Contenedor horizontal para los botones
            HStack{
                // Botón para decrementar el contador
                Button(action: {
                    if(numero > 1){
                        
                        numero -= 1
                    }
                }) {
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.cyan)
                        // Icono de resta
                        Image(systemName: "minus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            
                    }
                }
                // Botón para incrementar el contador
                Button(action: {
                    if(numero < 150){
                        
                        numero += 1
                    }

                }) {
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.cyan)
                        // Icono de suma
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            
                    }
                }
            }
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgrounComponent)
    }
}

// Definición de la estructura IMCCalculatorButton que conforma a View
struct IMCCalcularBoton:View {
    // Propiedades para almacenar el peso y la altura del usuario
    let usuarioPeso:Double
    let usuarioAltura:Double
    
    // El cuerpo de la vista, que define cómo se muestra en la pantalla
    var body: some View {
        NavigationStack{
            NavigationLink(destination: {IMCResultado(usuarioPeso: usuarioPeso, usuarioAltura: usuarioAltura)}){
                Text("Calcular")// Texto del enlace de navegación
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)// Fuente grande
                    .bold()// Negrita
                    .foregroundColor(.black)// Color del texto
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 100)// Tamaño del marco
                    .background(.backgrounComponent)// Aplica un fondo específico
            }
        }
    }
}


#Preview {
    IMCView()
}
