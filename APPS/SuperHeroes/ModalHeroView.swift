//
//  ModalHeroView.swift
//  APPS
//
//  Created by Ulises Martínez on 27/06/24.
//

import SwiftUI

// Definición de la vista modal para mostrar detalles de un superhéroe.
struct ModalHeroView: View {
    // ID único del superhéroe.
    let id:String
    // Estado para almacenar los detalles completos del superhéroe.
    @State private var superheroe: ApiNet.SuperHeroeCompleto? = nil
    // Indicador para controlar si la vista está cargando datos.
    @State private var cargando: Bool = true
    // Referencia bidireccional para controlar la visibilidad de la vista modal.
    @Binding var isOpen: Bool
    
    // La vista principal de la modal.
    var body: some View {
        NavigationView{
            VStack{
                // Muestra un indicador de progreso mientras se cargan los datos.
                if cargando{
                    ProgressView().tint(.backgroundAPITextPrimary).frame(width: 200, height: 200)
                }else if let superheroe = superheroe{
                    // Lista para mostrar los detalles del superhéroe.
                    List{
                        // Secciones para diferentes aspectos de la biografía del superhéroe.
                        Section(header: Text("Alias").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.backgroundAPITextPrimary)){
                            ForEach(superheroe.biography.aliases, id: \.self){alias in
                                Text(alias).font(.title2).foregroundColor(.backgroundAPITextSecondary).italic()
                            }
                        }.listRowBackground(Color.backgroundAPI).frame(maxWidth: .infinity, alignment: .center)
              
                    
                        Section(header: Text("Nacimiento").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.backgroundAPITextPrimary)){
                            Text(superheroe.biography.placeOfBirth)
                                .font(.title2)
                                .foregroundColor(.backgroundAPITextSecondary).italic()
                        }.listRowBackground(Color.backgroundAPI).frame(maxWidth: .infinity, alignment: .center)
                   
                            
                        Section(header: Text("Parientes").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.backgroundAPITextPrimary)){
                            Text(superheroe.connections.relatives)
                                .font(.title2)
                                .foregroundColor(.backgroundAPITextSecondary).italic()
                        }.listRowBackground(Color.backgroundAPI).frame(maxWidth: .infinity, alignment: .center)
                    
                        Section(header: Text("Ocupación").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.backgroundAPITextPrimary)){
                            Text(superheroe.work.occupation)
                                .font(.title2)
                                .foregroundColor(.backgroundAPITextSecondary).italic()
                        }.listRowBackground(Color.backgroundAPI).frame(maxWidth: .infinity, alignment: .center)
                    
                  
                        Section(header: Text("Base").font(.title).foregroundColor(.backgroundAPITextPrimary)){
                            Text(superheroe.work.base)
                                .font(.title2)
                                .foregroundColor(.backgroundAPITextSecondary).italic()
                        }.listRowBackground(Color.backgroundAPI).frame(maxWidth: .infinity, alignment: .center)
                        
                        Section(header: Text("Afiliación").font(.title).foregroundColor(.backgroundAPITextPrimary)){
                            Text(superheroe.connections.groupAffiliation)
                                .font(.title2)
                                .foregroundColor(.backgroundAPITextSecondary).italic()
                        }.listRowBackground(Color.backgroundAPI).frame(maxWidth: .infinity, alignment: .center)
                        
                
                        Section(header: Text("Debut").font(.title).foregroundColor(.backgroundAPITextPrimary)){
                            Text(superheroe.biography.firstAppearance)
                                .font(.title2)
                                .foregroundColor(.backgroundAPITextSecondary).italic()
                        }.listRowBackground(Color.backgroundAPI).frame(maxWidth: .infinity, alignment: .center)
                    
                    }
                }
                
            }// Botón para cerrar la vista modal.
            .navigationBarItems(trailing: Button(action:
                {isOpen.toggle()
            }, label:{
                Text("Cerrar").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundAPI)
            // Carga los detalles del superhéroe cuando la vista aparece.
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
