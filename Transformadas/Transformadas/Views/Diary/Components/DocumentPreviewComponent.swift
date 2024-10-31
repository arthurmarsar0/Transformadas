//
//  DocumentPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct DocumentPreviewComponent: View {
    var documents: [String]
    var isReduced: Bool
    
    var body: some View {
        HStack (spacing: 8) {
            ForEach(documents, id: \.self) { document in
                VStack (spacing: 4){
                    Image(systemName: "document.fill")
                        .font(.system(size: 32))
                    Text(document)
                        .font(.system(size: 11, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1...2)
                        .truncationMode(.tail)
                }.frame(width: 70)
            }
            
            if !isReduced {
                Spacer()
            }
        }
        .frame(maxWidth: isReduced ? 164.5 : 337)
    }
}

#Preview {
    DocumentPreviewComponent(documents: ["arquivo_examesangue_pdf gthyh hyh", "arquivo_examesangue_pdf"], isReduced: true)
}
