//
//  InfoSheetView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 07/11/24.
//

import SwiftUI
import SwiftData

struct UserInfoSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Query var users: [User]
    @State var user: User = User(modelID: nil, name: "", gender: "", transitionStart: Date.now, hormonalTherapyType: .ratherNotInform, pronouns: "")
    
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top){
                Color.bege.ignoresSafeArea()
                VStack(spacing: 24) {
                    VStack(spacing: 8){
                        VStack(alignment: .leading) {
                            Text("NOME")
                                .font(.system(size: 13, weight: .regular, design: .default))
                                .foregroundStyle(.marrom)
                            TextField("", text: $user.name)
                                .padding()
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white)
                                )
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("PRONOMES")
                                .font(.system(size: 13, weight: .regular, design: .default))
                                .foregroundStyle(.marrom)
                            TextField("", text: $user.pronouns)
                                .padding()
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white)
                                )
                        }
                        
                        VStack(alignment: .leading) {
                            Text("GÊNERO")
                                .font(.system(size: 13, weight: .regular, design: .default))
                                .foregroundStyle(.marrom)
                            TextField("", text: $user.gender)
                                .padding()
                                .frame(height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white)
                                )
                        }
                        
                        VStack(alignment: .leading) {
                            Text("TERAPIA HORMONAL")
                                .font(.system(size: 13, weight: .regular, design: .default))
                                .foregroundStyle(.marrom)
                            Picker("Terapia Hormonal", selection: $user.hormonalTherapyType) {
                                ForEach(HormonalTherapyType.allCases, id: \.self) { therapy in
                                    Text(therapy.displayName).tag(therapy)
                                }
                            }
                            .tint(.black)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.black)
                            .padding()
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.white)
                            )
                        }
                        
                        
                    }
                    
                    VStack(alignment: .leading) {
                        DatePicker("Transversário", selection: $user.transitionStart, displayedComponents: .date)
                            .font(.system(size: 17, weight: .regular, design: .default))
                            .tint(.red)
                            .foregroundStyle(.cinzaEscuro)
                            .padding(.horizontal)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.white)
                            )
                        Text("O Transversário é uma data pessoal que simboliza o início da transição de cada pessoa trans. Sinta-se livre para escolher um marco importante da sua jornada como Transversário!")
                            .font(.system(size: 13, weight: .regular, design: .default))
                            .foregroundStyle(.cinzaEscuro)
                            .padding()
                    }
                    
                    
                }
                .padding()
            }.onAppear {
                removeNavBarBackground()
                if let existingUser = users.filter({$0.modelID == appData.appleID}).first {
                    user.modelID = appData.appleID
                    user.name = existingUser.name
                    user.gender = existingUser.gender
                    user.hormonalTherapyType = existingUser.hormonalTherapyType
                    user.pronouns = existingUser.pronouns
                    user.transitionStart = existingUser.transitionStart
                }
            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Text("Conta")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.marrom)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        saveUser()
                        dismiss()
                    }) {
                        Text("OK")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.rosa)
                    }
                }
            }
        }
    }
    
    func saveUser() {
        if let existingUser = users.filter({$0.modelID == appData.appleID}).first {
            existingUser.name = user.name
            existingUser.gender = user.gender
            existingUser.hormonalTherapyType = user.hormonalTherapyType
            existingUser.pronouns = user.pronouns
            existingUser.transitionStart = user.transitionStart
        }
    }
}

