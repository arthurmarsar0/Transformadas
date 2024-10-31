//
//  MoodPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct MoodPreviewComponent: View {
    var mood: Mood
    var entryDate: Date
    var isReduced: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            Text(mood.emoji).font(.system(size: 32))
            
            VStack (alignment: .leading){
                Text(entryDate.hourFormatted)
                    .font(.system(size: 11, weight: .regular))
                Text(mood.name)
                    .font(.system(size: 15, weight: .regular))
                    .lineLimit(1)
            }.foregroundStyle(.white)
            if !isReduced {
                Spacer()
            }
        }.padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background{
            RoundedRectangle(cornerRadius: 8).fill(.rosaMedio)
        }.frame(maxWidth: isReduced ? 164.5 : 337)
    }
}

#Preview {
    MoodPreviewComponent(mood: .moreOrLess, entryDate: Date.now, isReduced: true)
}
