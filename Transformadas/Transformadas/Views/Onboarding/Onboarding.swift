//
//  MainOnboarding.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 10/11/24.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var appData: AppData
    @State var navigate = false
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                Color.bege.ignoresSafeArea()
                VStack(spacing: 0){
                    ZStack {
                        Color.verde.ignoresSafeArea()
                        Image("onboarding")
                    }
                    .frame(height: 320)
                    
                    ZStack(alignment: .top){
                        Color.bege.ignoresSafeArea()
                        VStack(spacing: 40){
                            Text("Boas-vindas ao Morphos")
                                .font(.system(size: 34, weight: .bold))
                            
                            
                            VStack(alignment: .leading, spacing: 28){
                                HStack{
                                    Image(systemName: "append.page.fill")
                                        .font(.system(size: 34, weight: .bold))
                                        .foregroundStyle(.verde)
                                    Text("Registre seu dia a dia e todas as nuances e etapas da sua transição")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.cinzaEscuro)
                                }
                                HStack{
                                    Image(systemName: "globe")
                                        .font(.system(size: 34, weight: .bold))
                                        .foregroundStyle(.verde)
                                    Text("Encontre serviços gratuitos e voltados para população trans perto de você")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.cinzaEscuro)
                                }
                                HStack{
                                    Image(systemName: "chart.bar.xaxis")
                                        .font(.system(size: 34, weight: .bold))
                                        .foregroundStyle(.verde)
                                    Text("Veja uma retrospectiva de toda a sua jornada e relembre momentos importantes")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.cinzaEscuro)
                                }
                                
                                
                            }
                            
                            
                        }
                        .padding()
                    }
                    
                }
                
                Button(action: {
                    navigate = true
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 50)
                            .foregroundStyle(.rosa)
                        Text("Seguinte")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                }.navigationDestination(isPresented: $navigate) {
                    SignIn()
                        .navigationBarBackButtonHidden()
                        .environmentObject(appData)
                }
            }
        }
    }
}
