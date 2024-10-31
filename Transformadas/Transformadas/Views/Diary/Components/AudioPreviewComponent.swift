//
//  AudioPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct AudioPreviewComponent: View {
    var audio: String
    var isReduced: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            VStack (alignment: .leading) {
                HStack {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 13, weight: .regular))
                    ///TO-DO: áudio
                    Text("00:15")
                        .font(.system(size: 11, weight: .regular))
                }.foregroundStyle(.white)
                
                
            }
            
            if !isReduced {
                Spacer()
            }
        }
        .padding(8)
        .background{
            RoundedRectangle(cornerRadius: 8).fill(.verdeMedio)
        }.frame(maxWidth: isReduced ? 164.5 : 337)
    }
}

#Preview {
    AudioPreviewComponent(audio: "", isReduced: true)
}
