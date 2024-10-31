//
//  DocumentPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct DocumentPreviewComponent: View {
    var documents: [String]
    var isPreview: Bool
    
    var body: some View {
        VStack (spacing: 12) {
            if !isPreview {
                HStack {
                    Text("DOCUMENTOS")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                }
            }
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
                Spacer()
                
            }
        }
      
    }
}

#Preview {
    DocumentPreviewComponent(documents: ["arquivo_examesangue_pdf gthyh hyh", "arquivo_examesangue_pdf"], isPreview: false)
}
