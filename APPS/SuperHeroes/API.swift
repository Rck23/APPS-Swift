//
//  API.swift
//  APPS
//
//  Created by Ulises Martínez on 25/06/24.
//

import Foundation

// Clase principal para interactuar con la API de superhéroes.
class ApiNet {
    // Estructura que representa las propiedades de la respuesta de la API,
    // incluyendo un array de superhéroes encontrados.
    struct Props:Codable{
        let results:[SuperHero]
    }
    // Estructura que representa a un superhéroe individual,
    // incluyendo su ID y nombre.
    struct SuperHero:Codable, Identifiable{
        let id:String
        let name:String
        
    }
    
    // Función asíncrona que busca superhéroes por consulta.
    // Toma una consulta como entrada y devuelve una promesa de Props.
    func getHeroesByQuery(query:String) async throws-> Props{
        // Construye la URL para la consulta a la API de superhéroes.
        let url = URL(string:"https://superheroapi.com/api/7d778dab16ce8006a10062e68b8f4096/search/\(query)")!
        
        // Realiza una llamada GET a la API y obtiene los datos.
        let (data, _) = try await URLSession.shared.data(from: url)
        // Decodifica los datos de la respuesta en una instancia de Props.
        let propiedades = try JSONDecoder().decode(Props.self, from: data)
        // Retorna las propiedades decodificadas.
        return propiedades
    }
    
}
