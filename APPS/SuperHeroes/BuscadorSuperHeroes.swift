//
//  BuscadorSuperHeroes.swift
//  APPS
//
//  Created by Ulises Martínez on 25/06/24.
//

import SwiftUI
// Dependencia para imagenes https://github.com/SDWebImage/SDWebImageSwiftUI
import SDWebImageSwiftUI

// Definición de la vista principal para buscar superhéroes.
struct BuscadorSuperHeroes: View {
    
    // Estado para almacenar el nombre del superhéroe buscado.
    @State var superHeroeNombre:String = ""
    // Estado para almacenar las propiedades obtenidas de la API.
    @State var props:ApiNet.Props? = nil
    // Estado para controlar si la búsqueda está en progreso.
    @State var cargando:Bool = false
    
    // La vista principal de la aplicación.
    var body: some View {
        VStack{
            // Campo de texto para ingresar el nombre del superhéroe.
            TextField("", text: $superHeroeNombre, prompt: Text("Buscar héroe...").font(.title2).bold().foregroundColor(.gray))
                .foregroundColor(.backgroundAPITextSecondary)
                .font(.title2)
                .bold()
                .padding(16)
                .border(.backgroundAPITextPrimary, width: 5)
                .cornerRadius(10)
                .padding(10)
                .autocorrectionDisabled()
            // Acción cuando se envía el formulario (por ejemplo, al presionar Enter).
                .onSubmit {
                    cargando = true
                    print(superHeroeNombre)
                    // Realiza la solicitud a la API en un background thread.
                    Task{
                        do{
                           props = try await ApiNet().getHeroesByQuery(query: superHeroeNombre)
                        }catch{
                            print("ERROR!")

                        }
                        cargando = false
                    }
                    
                }
            
            // Muestra un indicador de progreso mientras se carga la información.
            if cargando{
                ProgressView().tint(.backgroundAPITextPrimary).frame(width: 200, height: 200)
            }
            // Navegación hacia una lista de superhéroes encontrados.
            NavigationStack{
                List(props?.results ?? []){superheroe in
                    // Elemento de la lista que muestra un ítem de superhéroe.
                    ZStack{
                        SuperHeroeItem(superheroe: superheroe)
                        // Enlace de navegación oculto para permitir selección de elementos de la lista.
                        NavigationLink(destination: SuperHeroeDetalles(id: superheroe.id)){EmptyView()}.opacity(0)
                    }.listRowBackground(Color.backgroundAPI)
                    
                }.listStyle(.plain)
            
            }
            // Espacio adicional al final de la vista.
            Spacer()
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgroundAPI)
    }
}

// Vista para mostrar un ítem individual de superhéroe.
struct SuperHeroeItem:View {
    
    let superheroe: ApiNet.SuperHero
    
    var body: some View {
        ZStack{
            // Carga la imagen del superhéroe usando SDWebImage.
            WebImage(url: URL(string: superheroe.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            
            // Contenedor con el nombre del superhéroe.
            VStack{
                Spacer()
                Text(superheroe.name)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.backgroundAPITextPrimary.opacity(0.5))
            }
        }.frame(height: 200)
            .cornerRadius(16)
    }
}

#Preview {
    BuscadorSuperHeroes()
}
