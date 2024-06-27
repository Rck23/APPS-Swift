//
//  ModalHeroView.swift
//  APPS
//
//  Created by Ulises Martínez on 27/06/24.
//

import SwiftUI

struct ModalHeroView: View {
    let id:String
    @State private var superheroe: ApiNet.SuperHeroeCompleto? = nil
    @State private var cargando: Bool = true

    @Binding var isOpen: Bool
    
    var body: some View {
        NavigationView{
            VStack{
                if cargando{
                    ProgressView().tint(.backgroundAPITextPrimary).frame(width: 200, height: 200)
                }else if let superheroe = superheroe{
                    Spacer()
                    Text("Alias").font(.title).foregroundColor(.backgroundAPITextPrimary)
                    ForEach(superheroe.biography.aliases, id: \.self){alias in
                        Text(alias).font(.title2).foregroundColor(.backgroundAPITextSecondary).italic()
                    }
                    Spacer()

                    Text("Nacimiento").font(.title).foregroundColor(.backgroundAPITextPrimary)
                    Text(superheroe.biography.placeOfBirth)
                        .font(.title2)
                        .foregroundColor(.backgroundAPITextSecondary).italic()
                    Spacer()

                    Text("Parientes").font(.title).foregroundColor(.backgroundAPITextPrimary)
                    Text(superheroe.connections.relatives)
                        .font(.title2)
                        .foregroundColor(.backgroundAPITextSecondary).italic()
                    Spacer()

                    Text("Ocupación").font(.title).foregroundColor(.backgroundAPITextPrimary)
                    Text(superheroe.work.occupation)
                        .font(.title2)
                        .foregroundColor(.backgroundAPITextSecondary).italic()
                    Spacer()

                    Text("Base").font(.title).foregroundColor(.backgroundAPITextPrimary)
                    Text(superheroe.work.base)
                        .font(.title2)
                        .foregroundColor(.backgroundAPITextSecondary).italic()
                    Spacer()

                    Text("Afiliación").font(.title).foregroundColor(.backgroundAPITextPrimary)
                    Text(superheroe.connections.groupAffiliation)
                        .font(.title2)
                        .foregroundColor(.backgroundAPITextSecondary).italic()
                    
                    Spacer()

                    
                    Text("Debut").font(.title).foregroundColor(.backgroundAPITextPrimary)
                    Text(superheroe.biography.firstAppearance)
                        .font(.title2)
                        .foregroundColor(.backgroundAPITextSecondary).italic()
                    
                    

                }
            }.navigationBarItems(trailing: Button(action:
                {isOpen.toggle()
            }, label:{
                Text("Cerrar")
            }))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
}

