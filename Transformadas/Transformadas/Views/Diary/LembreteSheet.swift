//
//  LembreteSheet.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 29/10/24.
//

import SwiftUI

struct LembreteSheet: View {
    @Binding var isPresented: Bool
//    @Binding var details: String
    
    var body: some View {
        ZStack{
            //TODO: Adicionar a cor de fundo
            
            VStack {
                HStack { //Cabeçalho da Sheet
                    Button("Cancelar") {
                        isPresented.toggle()
                    }
                    .foregroundStyle(Color.black)
                    
                    Spacer()
                    
                    Text("Seu Dia") //TODO: Deixar em negrito
                        .bold()
                    
                    Spacer()
                    
                    Button("Registrar"){
                        isPresented.toggle()
                    }
                    .foregroundStyle(Color.red) // TODO: Trocar para rosa
                }
                .padding(.horizontal, 16)
                .padding(.top, 17)
                
                ScrollView {
                    VStack(alignment: .leading){
                        Text("COMO ESTÁ O SEU HUMOR?")
                            .foregroundStyle(Color.gray)
                            .padding(.top, 27)
                            .padding(.horizontal, 32)
                        
//                        HStack{  TODO: fazer o ForEach dos Botões
//                        }
                        
//                        TextField("Descreva este momento da sua trasição...", text: $details) //TODO: Ver como fazer sem precisar colocar o binding em tudo
                        
                        Text("MUDANÇAS FÍSICAS")
                            .foregroundStyle(Color.gray)
                            .padding(.top, 24)
                            .padding(.horizontal, 32)
                        
                        Button(action:{},
                               label:{
                            HStack {
                                Text("Gravar voz")
                                Spacer()
                                Image(systemName: "microphone.fill")
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(Color.red)
                        })
                        
                        
                        
                        
                        
                        Text("EFEITOS")
                            .foregroundStyle(Color.gray)
                            .padding(.top, 24)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.blue) // - para ver como está o frame da VStack
                    
                }
            }
        }
//        .ignoresSafeArea()
    }
}

#Preview {
    LembreteSheet(isPresented: .constant(true))
}
