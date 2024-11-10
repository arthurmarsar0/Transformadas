//
//  Onboarding.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 05/11/24.
//

import SwiftUI

struct Onboarding: View {
    @State private var currentPage = 0
    @EnvironmentObject var appData: AppData
    @State var name: String = ""
    @State var startDate = Date()
    @State var selectedTherapy: HormonalTherapyType = .rathernotinform
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottom){
                Color.bege.ignoresSafeArea()
                
                if(currentPage == 0){
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
                    .onAppear {
                        requestNotificationAccess { _ in
                            
                        }
                    }
                    
                }else{
                    VStack(spacing: 0){
                        ZStack(alignment: .top){
                            Color.bege.ignoresSafeArea()
                            VStack(spacing: 40){
                                VStack(spacing: 16){
                                    HStack{
                                        Spacer()
                                        Button {
                                            appData.primeiraAbertura = true
                                        } label: {
                                            Text("Ignorar")
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundStyle(.verde)
                                        }
                                        
                                    }
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: 34, weight: .bold))
                                        .foregroundStyle(.verdeMedio)
                                    Text("Configurar dados de perfil")
                                        .font(.system(size: 28, weight: .bold))
                                    Text("Seus dados de perfil serão usados para personalizar sua experiência e deixa-lá mais adequeada as suas preferências de tratamento")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundStyle(.cinzaEscuro)
                                }
                                .padding()
                                Form {
                                    TextField("Nome", text: $name)
                                        
                                    TextField("Gênero", text: $name)
                                        
                                    TextField("Pronomes", text: $name)
                                        
                                    Picker("Terapia Hormonal", selection: $selectedTherapy) {
                                        ForEach(HormonalTherapyType.allTypes, id: \.self) { therapy in
                                                Text(therapy.displayName).tag(therapy)
                                            }
                                                }
                                    DatePicker("Início de transição", selection: $startDate, displayedComponents: .date)
                                }
                                .scrollContentBackground(.hidden)
                                .background(.bege)
                            }
                        }
                        
                    }
                }
                Button {
                    if currentPage == 0 {
                        currentPage = 1
                    } else {
                        appData.primeiraAbertura = true
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 50)
                            .foregroundStyle(.rosa)
                        Text(currentPage == 0 ? "Seguinte" : "Continuar")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
