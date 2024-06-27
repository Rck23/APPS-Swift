//
//  MenuView.swift
//  APPS
//
//  Created by Ulises Martínez on 18/06/24.
//

import SwiftUI


struct MenuView: View {
    var body: some View {
        NavigationStack{
            VStack{
                
                List{
                    
                    NavigationLink(destination: IMCView()) {
                        Label("IMC Calculadora", systemImage: "checkmark")
                            .foregroundColor(.white).opacity(0.85)
                            .padding(.vertical,16)
                            .bold()
                                                       
                    }.font(.title2).listRowBackground(Color.black)
                    
                    NavigationLink(destination: BuscadorSuperHeroes()) {
                     
                        Label("Súper Heroes API", systemImage: "checkmark")
                            .foregroundColor(.white).opacity(0.85)
                            .bold()
                            
                                                                                   
                    }.font(.title2).listRowBackground(Color.black)


                    
                }.listStyle(.plain).background(.black)

                    



                
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text("Lista de Apps")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.vertical,10)
                    }
                    
                }
                
                

        }
    }
}

#Preview {
    MenuView()
}
