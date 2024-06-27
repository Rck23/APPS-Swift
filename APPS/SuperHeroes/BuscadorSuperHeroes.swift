//
//  BuscadorSuperHeroes.swift
//  APPS
//
//  Created by Ulises Martínez on 25/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct BuscadorSuperHeroes: View {
    
    @State var superHeroeNombre:String = ""
    
    @State var props:ApiNet.Props? = nil
    
    @State var cargando:Bool = false
    
    var body: some View {
        VStack{
            
            TextField("", text: $superHeroeNombre, prompt: Text("Buscar héroe...").font(.title2).bold().foregroundColor(.gray))
                .foregroundColor(.backgroundAPITextSecondary)
                .font(.title2)
                .bold()
                .padding(16)
                .border(.backgroundAPITextPrimary, width: 5)
                .cornerRadius(10)
                .padding(10)
                .autocorrectionDisabled()
                .onSubmit {
                    cargando = true
                    print(superHeroeNombre)
                    
                    Task{
                        do{
                           props = try await ApiNet().getHeroesByQuery(query: superHeroeNombre)
                        }catch{
                            print("ERROR!")

                        }
                        cargando = false
                    }
                    
                }
            
            if cargando{
                ProgressView().tint(.backgroundAPITextPrimary).frame(width: 200, height: 200)
            }
            NavigationStack{
                List(props?.results ?? []){superheroe in
                    
                    ZStack{
                        SuperHeroeItem(superheroe: superheroe)
                        NavigationLink(destination: SuperHeroeDetalles(id: superheroe.id)){EmptyView()}.opacity(0)
                    }.listRowBackground(Color.backgroundAPI)
                    
                }.listStyle(.plain)
            
            }
            Spacer()
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgroundAPI)
    }
}

struct SuperHeroeItem:View {
    let superheroe: ApiNet.SuperHero
    var body: some View {
        ZStack{
            
            WebImage(url: URL(string: superheroe.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            
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
