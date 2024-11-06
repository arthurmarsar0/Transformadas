//
//  AudioPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct AudioPreviewComponent: View {
    var audio: Audio
    var isPreview: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            VStack (alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 13, weight: .regular))
                    Text(audio.length.minutesAndSeconds)
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
    AudioPreviewComponent(audio: Audio(name: "", path: URL.downloadsDirectory, length: 0.0), isPreview: false)
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
