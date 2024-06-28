//
//  ListView.swift
//  APPS
//
//  Created by Ulises Martínez on 23/06/24.
//

import SwiftUI
// Arrays globales para almacenar instancias de pokemones y digimones.
var pokemones = [
    pokemon(nombre: "Pikachu"),
    pokemon(nombre: "Charmander"),
    pokemon(nombre: "Lia"),
    pokemon(nombre: "Machoke")
]

var digimones = [
    digimon( nombre: "Egomon"),
    digimon( nombre: "Gigamon"),
    digimon( nombre: "Carmon"),
]

// Vista para mostrar listas de pokemones y digimones.
struct ListView: View {
    var body: some View {
        /*List(pokemones, id: \.nombre) { pokemon in
            Text(pokemon.nombre)
        }*/
        // Lista con secciones para pokemones y digimones.
        List{
            // Sección para pokemones.
            Section(header: Text("Pokemones").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .center)){
                // Itera sobre cada pokemon y muestra su nombre.
                ForEach(pokemones, id: \.nombre) { pokemon in
                    Text(pokemon.nombre).frame(maxWidth: .infinity, alignment: .center)
                }
            }.listRowBackground(Color.white)// Configura el fondo de cada fila

            // Sección para digimones.
            Section(header: Text("Digimons")){
                // Itera sobre cada digimon y muestra su nombre.
                ForEach(digimones) { digimon in
                    Text(digimon.nombre).frame(maxWidth: .infinity, alignment: .center)
                }
            }.listRowBackground(Color.white)

        }.listStyle(.plain) // Usa el estilo de lista plano.
            .background(.backgroundSelected)
    }
}

// Estructura para representar un pokemon.
struct pokemon{
    let nombre: String
}

// Estructura para representar un digimon, que incluye un identificador único.
struct digimon: Identifiable{
    var id = UUID() // Genera un identificador único para cada digimon.
    let nombre: String
}


#Preview {
    ListView()
}
