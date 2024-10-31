//
//  NotePreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct NotePreviewComponent: View {
    var note: String
    var isReduced: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            Text(note)
                .font(.system(size: 13, weight: .regular))
                .multilineTextAlignment(.leading)
                .lineLimit(1...6)
                .truncationMode(.tail)
                .foregroundStyle(.cinzaEscuro)
                .lineSpacing(2)
                .background(.cinzaMuitoClaro)
            
            
            if !isReduced {
                Spacer()
            }
        }
        .padding(8)
        .background{
            RoundedRectangle(cornerRadius: 8).fill(.cinzaMuitoClaro)
        }.frame(maxWidth: isReduced ? 164.5 : 337)
    }
}

#Preview {
    NotePreviewComponent(note: "Querido diário, hoje eu notei que a minha barba começou a crescer mais nas laterais. O bigode, que já tava maior, agora está engrossando, o que é muito bom", isReduced: true)
}
