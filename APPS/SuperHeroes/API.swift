//
//  API.swift
//  APPS
//
//  Created by Ulises Martínez on 25/06/24.
//

import Foundation

// Clase principal para interactuar con la API de superhéroes.
class ApiNet {
    // Token de acceso para autenticarse en la API de superhéroes.
    let AccessToken = "7d778dab16ce8006a10062e68b8f4096"
    // URL base de la API de superhéroes.
    let BaseUrl = "https://superheroapi.com/api"
    
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
        let image:ImagenSuperHero
    }
    
    struct ImagenSuperHero:Codable{
        let url:String
        
        
    }

    
    // Función asíncrona que busca superhéroes por consulta.
    // Toma una consulta como entrada y devuelve una promesa de Props.
    func getHeroesByQuery(query:String) async throws-> Props{
        // Construye la URL para la consulta a la API de superhéroes.
        let url = URL(string:"\(BaseUrl)/\(AccessToken)/search/\(query)")!
        
        // Realiza una llamada GET a la API y obtiene los datos.
        let (data, _) = try await URLSession.shared.data(from: url)
        // Decodifica los datos de la respuesta en una instancia de Props.
        let propiedades = try JSONDecoder().decode(Props.self, from: data)
        // Retorna las propiedades decodificadas.
        return propiedades
    }
    
    // Función asíncrona que obtiene los detalles de un superhéroe por su ID.
    func getHeroeById (id:String) async throws ->SuperHeroeCompleto{
        // URL dinámica basada en el ID del superhéroe.
        let url = URL(string:"\(BaseUrl)/\(AccessToken)/\(id)")!
        
        // Llama a la API y recibe los datos.
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decodifica los datos recibidos.
        return try JSONDecoder().decode(SuperHeroeCompleto.self, from: data)
        

    }
    
    // Estructura completa de un superhéroe.
       struct SuperHeroeCompleto:Codable {
           let id:String // ID único del superhéroe.
           let name:String // Nombre del superhéroe.
           let image:ImagenSuperHero // Imagen del superhéroe.
           let powerstats:Powerstats // Estadísticas de poder del superhéroe.
           let biography:Biography // Biografía del superhéroe.
           let appearance:Appearance // Apariencia del superhéroe.
           let work:Work // Información laboral del superhéroe.
           let connections:Connections // Conexiones del superhéroe.
       }
    
    // Estadísticas de poder de un superhéroe.
     struct Powerstats:Codable{
         let intelligence:String // Inteligencia.
         let strength:String // Fuerza.
         let speed:String // Velocidad.
         let durability:String // Durabilidad.
         let power:String // Poder.
         let combat:String // Combate.
     }
    
    // Apariencia de un superhéroe.
       struct Appearance:Codable{
           let gender: String // Género.
           let race: String // Raza.
       }
    
    // Biografía de un superhéroe.
        struct Biography:Codable{
            let aliases:[String] // Alias del superhéreo.
            let publisher:String // Editor.
            let alignment:String // Alineación.
            let fullName:String // Nombre completo.
            let placeOfBirth:String // Lugar de nacimiento.
            let firstAppearance:String // Primera aparición.
            
            // Enumeración para codificar claves personalizadas.
            enum CodingKeys:String, CodingKey{
                case fullName = "full-name" // Nombre completo.
                case aliases = "aliases" // Alias.
                case publisher = "publisher" // Editor.
                case alignment = "alignment" // Alineación.
                case placeOfBirth = "place-of-birth" // Lugar de nacimiento.
                case firstAppearance = "first-appearance" // Primera aparición.
            }
        }
    
    // Información laboral de un superhéroe.
      struct Work:Codable{
          let occupation:String // Ocupación.
          let base:String // Base.
      }
      
      // Conexiones de un superhéroe.
      struct Connections:Codable{
          let relatives:String // Familiares.
          let groupAffiliation:String // Afiliaciones grupales.
          
          // Enumeración para codificar claves personalizadas.
          enum CodingKeys:String, CodingKey{
              case groupAffiliation = "group-affiliation" // Afiliaciones grupales.
              case relatives = "relatives" // Familiares.
          }
      }
    
}
