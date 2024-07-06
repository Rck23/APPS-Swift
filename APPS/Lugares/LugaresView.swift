//
//  LugaresView.swift
//  APPS
//
//  Created by Ulises Martínez on 04/07/24.
//

import SwiftUI
import MapKit
// Define la vista principal de la aplicación, que muestra un mapa y gestiona lugares
struct LugaresView: View {
    
    // Estado inicial de la cámara del mapa centrada en una ubicación específica
    @State var posicion = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 21.8832499, longitude: -102.293703),
                           span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)))
    // Lista de lugares marcados en el mapa
    @State var lugares: [Lugar]  = []

    // Coordenadas de la ubicación seleccionada para mostrar detalles
    @State var showPopUp:CLLocationCoordinate2D? = nil
   
    // Variables de estado para el formulario de agregar nuevo lugar
    @State var nombre:String = ""
    @State var fav:Bool = false
    
    // Variable de estado para controlar la presentación de la hoja de lista de lugares
    @State var showSheet:Bool = false
    // Rango de alturas para la presentación detenta de la hoja
    let altura = stride(from: 0.3, through: 0.3, by: 0.1).map{PresentationDetent.fraction($0)}
    // Implementación de la vista
    var body: some View {
        ZStack{        // Contenedor principal que permite superponer vistas.

            MapReader{proxy in
                // Componente personalizado que envuelve el Map de MapKit.
                // Proporciona funcionalidades adicionales no mostradas aquí.
                Map(position: $posicion){
                    // Itera sobre la lista de lugares para dibujar marcadores en el mapa.
                    ForEach(lugares){ lugar in
                        // Crea un marcador para cada lugar basado en su nombre y coordenadas.
                        Annotation(lugar.nombre, coordinate: lugar.coordenadas){
                            // Determina el color del círculo basado en si el lugar es favorito.
                            let color = if lugar.fav {Color.yellow} else {Color.black}
                            Circle()
                                .stroke(color, lineWidth: 3)
                                .fill(.white)
                                .frame(width: 15, height: 15)
                        }
                    }
                } // Maneja el evento de toque en un marcador para mostrar un diálogo con detalles del lugar.
                    .onTapGesture { coordenada in
                        if let coordenadas = proxy.convert(coordenada, from: .local){
                            showPopUp  = coordenadas
                        }
                        
                    }
                // Añade un botón sobre el mapa para abrir la lista de lugares.
                    .overlay{
                        VStack{
                            Button("Lista"){
                                showSheet = true
                            }
                            .padding(.horizontal,16)
                            .padding(.vertical, 8)
                            .background(.white)
                            .cornerRadius(16)
                            .padding(16)
                            Spacer()
                        }
                    }
            }
            // Muestra un diálogo personalizado para agregar nuevos lugares cuando se selecciona una ubicación en el mapa.
            if showPopUp != nil {
                
                let vista = VStack{
                    
                    Text("Añadir localización").font(.title).bold()
                    Spacer()
                    TextField("Nombre", text: $nombre).padding(.bottom, 8)
                    Toggle("Lugar favorito", isOn: $fav)
                    Spacer()
                    Button("Guardar"){
                        guardarLugar(nombre: nombre, fav: fav, coordenadas: showPopUp!)
                        
                        limpiarForm()
                    }
                }
                
                withAnimation {
                    DialogoCustom(cerrarDialogo: {
                        showPopUp = nil
                    }, onDismissOutside: false, contenido: vista)
                }
            }
        }
        // Presenta una hoja modal con una lista de todos los lugares.
        .sheet(isPresented: $showSheet){
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(lugares){ lugar in
                        let color = if lugar.fav{ Color.yellow.opacity(0.5) }else{ Color.gray.opacity(0.5) }
                        VStack{
                            Text(lugar.nombre).font(.title2).bold()
                        }.frame(width: 150, height: 100).overlay{
                            RoundedRectangle(cornerRadius: 20).stroke(color, lineWidth: 1)
                        }.shadow(radius: 5).padding(.horizontal, 8)
                            .onTapGesture {
                                animarCamara(coordenadas: lugar.coordenadas)
                                showSheet = false
                            }
                    }
                }
            }.presentationDetents(Set(altura))
        // Carga los lugares guardados desde UserDefaults cuando la vista aparece.
        }.onAppear{
            cargarLugares()
        }
    }
    // Función para guardar un nuevo lugar en la lista
    func guardarLugar(nombre:String, fav:Bool, coordenadas:CLLocationCoordinate2D){
        let lugar = Lugar(nombre: nombre, fav: fav, coordenadas: coordenadas)
        lugares.append(lugar)
        guardarLugares()
    }
    // Función para limpiar el formulario de agregar lugar
    func limpiarForm(){
        nombre = ""
        fav = false
        showPopUp = nil
    }
    // Función para animar la cámara al lugar seleccionado
    func animarCamara(coordenadas: CLLocationCoordinate2D){
        withAnimation{
            posicion = MapCameraPosition.region(
                MKCoordinateRegion(center: coordenadas,
                                   span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)))
        }
    }
}

// Extensión para manejar la persistencia de lugares en UserDefaults
extension LugaresView{
    /// Función para guardar la lista de lugares en UserDefaults.
       /**
        - Descripción: Esta función convierte la lista de lugares a datos codificados en formato JSON y los guarda en UserDefaults bajo la clave "lugares".
        - Nota: Se utiliza JSONEncoder para la conversión a datos codificados.
        */
    func guardarLugares(){
        if let encodeData = try? JSONEncoder().encode(lugares){
            UserDefaults.standard.set(encodeData, forKey: "lugares")
        }
    }
  
    /// Función para cargar la lista de lugares desde UserDefaults.
    /**
     - Descripción: Esta función intenta recuperar los datos codificados de UserDefaults bajo la clave "lugares" y decodificarlos de vuelta a una lista de objetos Lugar usando JSONDecoder.
     - Nota: Si los datos están presentes y son válidos, se asignan a la propiedad `lugares` de la vista.
     */
    func cargarLugares(){
        if let lugaresGuardados = UserDefaults.standard.data(forKey: "lugares"),
           let decodedLugares =  try? JSONDecoder().decode([Lugar].self, from: lugaresGuardados){
               lugares = decodedLugares
           }
    }
}

#Preview {
    LugaresView()
}
