//
//  NotePreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct NotePreviewComponent: View {
    var note: String
    var isPreview: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(note)
                .font(.system(size: isPreview ? 13 : 17, weight: .regular))
                .multilineTextAlignment(.leading)
                .lineLimit(isPreview ? 6 : nil)
                .truncationMode(.tail)
                .foregroundStyle(.cinzaEscuro)
                .lineSpacing(2)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 8).fill(.cinzaMuitoClaro)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NotePreviewComponent(note: "Querido diário, hoje eu notei que a minha barba começou a crescer mais nas laterais. O bigode, que já tava maior, agora está engrossando, o que é muito bom", isPreview: false)
}
