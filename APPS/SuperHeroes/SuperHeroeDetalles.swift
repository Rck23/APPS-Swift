//
//  SuperHeroeDetalles.swift
//  APPS
//
//  Created by Ulises Martínez on 26/06/24.
//

import SwiftUI
import SDWebImageSwiftUI // Dependencia para imagenes https://github.com/SDWebImage/SDWebImageSwiftUI
import Charts // Dependencia de graficas

// Vista para mostrar detalles completos de un superhéroe.
struct SuperHeroeDetalles: View {
    // ID único del superhéroe.
    let id:String
    // Detalles del superhéroe obtenidos de la API.
    @State var superheroe: ApiNet.SuperHeroeCompleto? = nil
    // Indicador para controlar si la vista está cargando datos.
    @State var cargando: Bool = true
    // Controla la visibilidad de la vista modal.
    @State private var isOpen: Bool = false
    
    var body: some View {
            VStack{
                // Muestra un indicador de progreso mientras se cargan los datos.
                if cargando{
                    ProgressView().tint(.backgroundAPITextPrimary).frame(width: 200, height: 200)
                }else if let superheroe = superheroe{
                    // Muestra la imagen del superhéroe.
                    WebImage(url: URL(string: superheroe.image.url))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(16)
                        .padding(.horizontal, 10)
                    // Muestra el nombre y la raza del superhéroe.
                    HStack{
                        
                        Text(superheroe.name)
                            .bold().font(.title)
                            .foregroundColor(.backgroundAPITextPrimary)
                        
                        Text("'\(superheroe.appearance.race)'")
                            .font(.system(size: 22))
                            .italic()
                            .foregroundColor(.backgroundAPITextSecondary)
                    }
                    // Muestra el nombre completo y la editorial del superhéroe.
                    Text(superheroe.biography.fullName)
                        .font(.title2)
                        .foregroundColor(.black)

                    Text(superheroe.biography.publisher)
                        .bold().font(.title2)
                        .foregroundColor(.black).underline().padding(.bottom,3).italic()
                    
                    
                    // Muestra las estadísticas de poder del superhéroe.
                    SuperheroEstadisticas(stats: superheroe.powerstats)
                    
                    // Botón para abrir la vista modal con más detalles.
                        Button {
                            isOpen.toggle()
                        } label: {
                            Text("Más información...")
                                .font(.title3)
                                .bold()
                            
                        }.sheet(isPresented: $isOpen){
                            ModalHeroView(id: id, isOpen: $isOpen)
                            //.presentationDetents([.medium, .large])
                    } .padding()
                        .background(.backgroundAPITextSecondary)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        
                    Spacer()
                    
                }

                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.backgroundAPI)
                .onAppear{
                    Task{
                        do{
                            superheroe = try await ApiNet().getHeroeById(id: id)
                        }catch{
                            superheroe = nil
                        }
                        cargando = false
                    }
                }
        }
    
}
// Vista para mostrar las estadísticas de poder de un superhéroe.
struct SuperheroEstadisticas:View {
    // Estadísticas de poder del superhéroe.
    let stats: ApiNet.Powerstats
    
    var body: some View {
        VStack{
            // Gráfico sectorial para cada estadística de poder.
            Chart{
                SectorMark(angle: .value("Count", Int(stats.combat) ?? 0),
                           innerRadius: .ratio(0.5),
                           angularInset: 2
                ).cornerRadius(10).foregroundStyle(by: .value("Category", "Combate"))
                
                SectorMark(angle: .value("Count", Int(stats.durability) ?? 0),
                           innerRadius: .ratio(0.5),
                           angularInset: 5
                ).cornerRadius(10).foregroundStyle(by: .value("Category", "Durabilidad"))
                
                SectorMark(angle: .value("Count", Int(stats.intelligence) ?? 0),
                           innerRadius: .ratio(0.5),
                           angularInset: 5
                ).cornerRadius(10).foregroundStyle(by: .value("Category", "Inteligencia"))
                
                SectorMark(angle: .value("Count", Int(stats.power) ?? 0),
                           innerRadius: .ratio(0.5),
                           angularInset: 5
                ).cornerRadius(10).foregroundStyle(by: .value("Category", "Poder"))
                
                SectorMark(angle: .value("Count", Int(stats.speed) ?? 0),
                           innerRadius: .ratio(0.5),
                           angularInset: 5
                ).cornerRadius(10).foregroundStyle(by: .value("Category", "Velocidad"))
                
                SectorMark(angle: .value("Count", Int(stats.strength) ?? 0),
                           innerRadius: .ratio(0.5),
                           angularInset: 5
                ).cornerRadius(10).foregroundStyle(by: .value("Category", "Fortaleza"))

            }
            
        }.padding(8)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 5000)
            .background(.backgroundAPI)
            .cornerRadius(16)
            .padding(.horizontal, 10)
    }
}


#Preview {
    SuperHeroeDetalles(id: "63")
}
