//
//  InfoSheetView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 07/11/24.
//

import SwiftUI



struct UserInfoSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @State var startDate: Date = Date()
    @State var selectedTherapy: HormonalTherapyType = .rathernotinform
    var body: some View {
        ZStack(alignment: .top){
            Color.bege.ignoresSafeArea()
            VStack(spacing: 24){
                HStack{
                    Text("Conta")
                    
                    Spacer()
                    Button("OK"){
                        dismiss()
                    }
                    .foregroundStyle(.rosa)
                }
                .font(.system(size: 17, weight: .semibold, design: .default))

                    VStack(spacing: 8){
                        VStack(alignment: .leading) {
                            Text("NOME")
                                .font(.system(size: 13, weight: .regular, design: .default))
                                .foregroundStyle(.marrom)
                            TextField("", text: $name)
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
                            TextField("", text: $name)
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
                            TextField("", text: $name)
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
                            Picker("Terapia Hormonal", selection: $selectedTherapy) {
                                ForEach(HormonalTherapyType.allTypes, id: \.self) { therapy in
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
                                DatePicker("Transversário", selection: $startDate, displayedComponents: .date)
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
        }
    }
}

