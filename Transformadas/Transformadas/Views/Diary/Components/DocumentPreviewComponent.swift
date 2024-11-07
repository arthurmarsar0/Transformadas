//
//  DocumentPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct DocumentPreviewComponent: View {
    var documents: [Document]
    var isPreview: Bool
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack (spacing: 12) {
            if !isPreview && !documents.isEmpty {
                HStack {
                    Text("DOCUMENTOS")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                }
            }
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(documents, id: \.self) { document in
                    VStack (spacing: 4){
                        Image(systemName: "document.fill")
                            .font(.system(size: 32))
                        Text(document.name)
                            .font(.system(size: 11, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1...2)
                            .truncationMode(.tail)
                    }
                }
            }
        }
    }
    
}

#Preview {
    DocumentPreviewComponent(documents: [], isPreview: false)
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
