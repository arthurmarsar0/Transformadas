//
//  InfoSheetView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 07/11/24.
//

import SwiftUI



struct InfoSheetView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView{
            VStack(spacing: 38){
                VStack(spacing: 8){
                    HStack{
                        Button("OK"){
                            dismiss()
                        }
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .foregroundStyle(.verde)
                        Spacer()
                    }
                    Text("O que procurar...")
                        .font(.system(size: 28, weight: .regular, design: .default))
                }
                VStack(spacing: 24){
                    ForEach(Category.allCases, id: \.self){ category in
                        if(category.name != "Todos"){
                            HStack(spacing: 16){
                                Image(systemName: category.symbol)
                                    .foregroundStyle(category.color)
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .frame(width: 40, height: 40)
                                VStack(alignment: .leading, spacing: 4){
                                    Text("Serviços " + (category.name == "Proteção" ? "de " : "") + category.name)   .font(.system(size: 17, weight: .semibold, design: .default))
                                    Text(category.text)
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                        .foregroundStyle(.cinzaEscuro)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

