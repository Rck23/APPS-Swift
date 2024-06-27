//
//  SuperHeroeDetalles.swift
//  APPS
//
//  Created by Ulises Martínez on 26/06/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

struct SuperHeroeDetalles: View {
    
    let id:String
    
    @State var superheroe: ApiNet.SuperHeroeCompleto? = nil
    @State var cargando: Bool = true
    
    @State private var isOpen: Bool = false
    
    var body: some View {
        VStack{
            
            if cargando{
                ProgressView().tint(.backgroundAPITextPrimary).frame(width: 200, height: 200)
            }else if let superheroe = superheroe{
                WebImage(url: URL(string: superheroe.image.url))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(16)
                    .padding(.horizontal, 10)
                    
                HStack{
                    
                    Text(superheroe.name)
                        .bold().font(.title)
                        .foregroundColor(.backgroundAPITextPrimary)
                    
                    Text("'\(superheroe.appearance.race)'")
                        .font(.system(size: 22))
                        .italic()
                        .foregroundColor(.backgroundAPITextSecondary)
                }
                
                Text(superheroe.biography.fullName)
                    .font(.title2)
                    .foregroundColor(.black)

                Text(superheroe.biography.publisher)
                    .bold().font(.title2)
                    .foregroundColor(.black).underline().padding(.bottom,3).italic()
                
                
                SuperheroEstadisticas(stats: superheroe.powerstats)
                
                
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

struct SuperheroEstadisticas:View {
    
    let stats: ApiNet.Powerstats
    
    var body: some View {
        VStack{
            
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
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 380)
            .background(.backgroundAPI)
            .cornerRadius(16)
            .padding(.horizontal, 10)
    }
}


#Preview {
    SuperHeroeDetalles(id: "63")
}
