//
//  AllAudiosView.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 08/11/24.
//

import SwiftUI

struct AllAudiosView: View {
    var body: some View {
        ZStack{
            Color.bege
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("Meus Áudios")
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
    AllAudiosView()
}
