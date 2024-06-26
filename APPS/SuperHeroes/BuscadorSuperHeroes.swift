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
    
    var body: some View {
        VStack{
            
            TextField("", text: $superHeroeNombre, prompt: Text("Buscar héroe...").font(.title2).bold().foregroundColor(.gray))
                .foregroundColor(.white)
                .font(.title2)
                .bold()
                .padding(16)
                .border(.purple, width: 4)
                .cornerRadius(10)
                .padding(10)
                .autocorrectionDisabled()
                .onSubmit {
                    print(superHeroeNombre)
                    
                    Task{
                        do{
                           props = try await ApiNet().getHeroesByQuery(query: superHeroeNombre)
                        }catch{
                            print("ERROR!")

                        }
                    }
                    
                    
                }
            
            List(props?.results ?? []){
                superheroe in SuperHeroeItem(superheroe: superheroe)
            }.listStyle(.plain)
            
            Spacer()
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity).background(.backgroundApp)
    }
}

struct SuperHeroeItem:View {
    let superheroe: ApiNet.SuperHero
    var body: some View {
        ZStack{
            Rectangle()
            
            VStack{
                Spacer()
                Text(superheroe.name)
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.white.opacity(0.3))
            }
        }.frame(height: 200).cornerRadius(20).background(.backgroundApp)
    }
}

#Preview {
    BuscadorSuperHeroes()
}
