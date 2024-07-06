//
//  Lugar.swift
//  APPS
//
//  Created by Ulises Martínez on 04/07/24.
//

import Foundation
import MapKit

struct Lugar: Identifiable, Codable  {
    /// Un identificador único para cada instancia de Lugar.
    var id = UUID()
    /// El nombre del lugar.
    var nombre: String
    /// Indica si el lugar es marcado como favorito.
    var fav: Bool
    /// Las coordenadas geográficas del lugar.
    var coordenadas: CLLocationCoordinate2D
        
    // Enumeración utilizada para codificar y decodificar instancias de Lugar.
    enum CodingKeys: CodingKey{
        // El identificador único del lugar, El nombre del lugar, Las coordenadas geográficas del lugar, Indica si el lugar es marcado como favorito, La latitud de las coordenadas geográficas del lugar, La longitud de las coordenadas geográficas del lugar.
                
        case id, nombre, coordenadas, fav, latitude, longitude
    }
    /// Inicializador que crea una nueva instancia de Lugar con las propiedades especificadas.
      ///
      /// - Parameters:
      ///   - id: El identificador único del lugar. Por defecto se genera un nuevo UUID.
      ///   - nombre: El nombre del lugar.
      ///   - fav: Indica si el lugar es marcado como favorito.
      ///   - coordenadas: Las coordenadas geográficas del lugar.
    init(id: UUID = UUID(), nombre: String, fav: Bool, coordenadas: CLLocationCoordinate2D) {
        self.id = id
        self.nombre = nombre
        self.fav = fav
        self.coordenadas = coordenadas
    }
    /// Inicializador que decodifica una instancia de Lugar a partir de un Decoder.
        ///
        /// - Throws: Si ocurre algún error durante la decodificación.
    init(from decoder: Decoder) throws {
        let contenedor = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try contenedor.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try contenedor.decode(CLLocationDegrees.self, forKey: .longitude)
        
        coordenadas = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        nombre = try contenedor.decode(String.self, forKey: .nombre)
        fav = try contenedor.decode(Bool.self, forKey: .fav)
        id = try contenedor.decode(UUID.self, forKey: .id)
    }
    /// Método que codifica una instancia de Lugar a un Encoder.
    ///
    /// - Throws: Si ocurre algún error durante la codificación.
    func encode(to encoder: Encoder) throws {
        var contenedor = encoder.container(keyedBy: CodingKeys.self)
        try contenedor.encode(coordenadas.latitude, forKey: .latitude)
        try contenedor.encode(coordenadas.longitude, forKey: .longitude)
        try contenedor.encode(nombre, forKey: .nombre)
        try contenedor.encode(fav, forKey: .fav)
        try contenedor.encode(id, forKey: .id)
        
    }
}

