//
//  AudioPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct AudioPreviewComponent: View {
    var audio: String
    var isPreview: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            VStack (alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 13, weight: .regular))
                    ///TO-DO: audio length
                    Text("00:15")
                        .font(.system(size: 11, weight: .regular))
                    Spacer()
                    
                    if !isPreview {
                        Text("MINHA VOZ")
                            .foregroundStyle(.azul)
                            .font(.system(size: 11, weight: .regular))
                    }
                    
                }.foregroundStyle(.white)
                
                ///TO-DO audio waveform
                Image(systemName: "waveform")
                    .foregroundStyle(isPreview ? .verde : .preto)
            }
            
        }
        .padding(8)
        .background{
            RoundedRectangle(cornerRadius: 8).fill(backgroundFill)
        }
        
    }
    
    private var backgroundFill: AnyShapeStyle {
        if isPreview {
            return AnyShapeStyle(Color.verdeMedio)
        } else {
            return AnyShapeStyle(degradeVerde())
        }
    }
}

#Preview {
    AudioPreviewComponent(audio: "", isPreview: false)
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
