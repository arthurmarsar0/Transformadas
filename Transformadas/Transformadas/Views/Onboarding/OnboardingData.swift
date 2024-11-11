//
//  Onboarding.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 05/11/24.
//

import SwiftUI
import SwiftData

struct OnboardingData: View {
    @State private var currentPage = 0
    @EnvironmentObject var appData: AppData
    @State var name: String = ""
    @State var gender: String = ""
    @State var pronouns: String = ""
    @State var startDate = Date.now
    @State var selectedTherapy: HormonalTherapyType = .ratherNotInform
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                Color.bege.ignoresSafeArea()
                VStack{
                    VStack(spacing: 0){
                        
                        ZStack(alignment: .top){
                            
                            Color.bege.ignoresSafeArea()
                            
                            VStack(spacing: 40){
                                VStack(spacing: 16){
                                    
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
                                    
                                    TextField("Gênero", text: $gender)
                                    
                                    TextField("Pronomes", text: $pronouns)
                                    
                                    Picker("Terapia Hormonal", selection: $selectedTherapy) {
                                        ForEach(HormonalTherapyType.allCases, id: \.self) { therapy in
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
                    
                    Button(action: {
                        
                        registerUser()
                        
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(height: 50)
                                .foregroundStyle(.rosa)
                            Text("Continuar")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                    }
                    
                }
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        registerUser()
                    } label: {
                        Text("Ignorar")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.verde)
                    }
                    
                }
            }.modifier(KeyboardDismiss())
        }
    }
    
    func registerUser() {
        
        var newUser = User(modelID: appData.appleID, name: name, gender: gender, transitionStart: startDate, hormonalTherapyType: selectedTherapy, pronouns: pronouns)
        
        
        if selectedTherapy == .feminization || selectedTherapy == .masculization {
            for effect in EffectEnum.allCases {
                if effect.type == selectedTherapy || effect.type == .ratherNotInform {
                    modelContext.insert(effect.effect)
                }
            }
        }
        
        modelContext.insert(newUser)
        
        appData.primeiraAbertura = true
    }
}


#Preview {
    Onboarding()
        .environmentObject(AppData())
}
