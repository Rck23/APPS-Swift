//
//  ListView.swift
//  APPS
//
//  Created by Ulises Martínez on 23/06/24.
//

import SwiftUI

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


struct ListView: View {
    var body: some View {
        /*List(pokemones, id: \.nombre) { pokemon in
            Text(pokemon.nombre)
        }*/
        
        List{
            Section(header: Text("Pokemones")){
                ForEach(pokemones, id: \.nombre) { pokemon in
                    Text(pokemon.nombre)
                }
            }
            Section(header: Text("Digimons")){
                ForEach(digimones) { digimon in
                    Text(digimon.nombre)
                }
            }
        }.listStyle(.grouped)
    }
}

struct pokemon{
    let nombre: String
}

struct digimon: Identifiable{
    var id = UUID()
    let nombre: String
}


#Preview {
    ListView()
}
