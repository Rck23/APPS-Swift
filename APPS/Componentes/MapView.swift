//
//  MapView.swift
//  APPS
//
//  Created by Ulises Martínez on 28/06/24.
//

import SwiftUI
import MapKit // Importa MapKit para trabajar con mapas

struct MapView: View { // Define una nueva vista personalizable
    // Variable de estado para almacenar la posición del mapa
    @State var posicion = MapCameraPosition.region(
        MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude:21.8699449, longitude:  -102.2745598)
                , span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )
    var body: some View {
        ZStack{ // Contenedor para superponer vistas
            MapReader{ proxy in // Accede a funcionalidades del mapa
                Map(position: $posicion){ // Configura el mapa con la posición actual
                    
                   /* Marker("Pollo", coordinate: CLLocationCoordinate2D(latitude:21.8699449, longitude:  -102.2745598)) */
                    
                    Annotation("Pollo 2", coordinate: CLLocationCoordinate2D(latitude:21.8699449, longitude:  -102.2745598)){
                        Image(systemName: "heart.fill").frame(height: 40).foregroundColor(.red)// Icono de la anotación
                    }.annotationTitles(.hidden) // Oculta títulos de anotaciones
                    
                }
                    .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true)) // Establece el estilo del mapa
                
                /*.onMapCameraChange {context in
                 print("Estamos en \(context)")
                 }*/
                    .onMapCameraChange(frequency:.continuous) {context in // Observa cambios en la cámara del mapa
                                        print("Estamos en \(context)") // Imprime información sobre el cambio
                                    }
                
                    .onTapGesture { position in // Maneja toques en el mapa
                         if let cordenadas = proxy.convert(position, from:.local){ // Convierte la posición local a coordenadas
                             withAnimation{ // Realiza animaciones suaves

                                 // Actualiza la posición del mapa
                                posicion = MapCameraPosition.region(
                                    MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: cordenadas.latitude, longitude: cordenadas.longitude)
                                        , span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                                    )
                                )
                            }
                        }
                    }
            }
            
           
            VStack{ // Contenedor vertical para botones
                Spacer() // Espacio para ajustar la disposición
                
                HStack{ // Contenedor horizontal para agrupar botones
                    Button("Ir al sur"){ // Botón para mover la cámara al sur
                        withAnimation{ // Realiza animaciones suaves
                            
                            posicion = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude:21.827627, longitude:  -102.2927883)
                                    , span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                                )
                            )
                        }
                    }.padding(20).background(.black).font(.title).bold().foregroundColor(.white).clipShape(.capsule).padding()
                    
                    Button("Ir al norte"){ // Botón para mover la cámara al norte
                    withAnimation{ // Realiza animaciones suaves
                            posicion = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude:21.9255392, longitude:  -102.3095147)
                                    , span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                                )
                            )
                        }
                    }.padding(20).background(.black).font(.title).bold().foregroundColor(.white).clipShape(.capsule).padding()
                }
            }
        }
    }
}

#Preview {
    MapView()
}
