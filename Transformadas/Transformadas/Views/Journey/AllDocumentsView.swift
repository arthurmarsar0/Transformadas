//
//  AllDocumentsView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 08/11/24.
//

import SwiftUI

struct AllDocumentsView: View {
    var body: some View {
        ZStack{
            Color.bege
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Meus Arquivos")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.marrom)
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AllDocumentsView()
}
