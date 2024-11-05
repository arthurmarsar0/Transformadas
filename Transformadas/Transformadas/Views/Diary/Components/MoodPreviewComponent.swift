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
    var isPreview: Bool
    
    var body: some View {
        HStack (spacing: 12) {
            Text(mood.emoji).font(.system(size: 32))
            
            VStack (alignment: .leading, spacing: 2){
                
                if isPreview {
                    Text(entryDate.hourFormatted)
                        .font(.system(size: 11, weight: .regular))
                    Text(mood.name)
                        .font(.system(size: 15, weight: .regular))
                        .lineLimit(1...2)
                } else {
                    Text("COMO ESTOU ME SENTINDO")
                        .font(.system(size: 11, weight: .regular))
                    Text(mood.name)
                        .font(.system(size: 20, weight: .medium))
                        .lineLimit(1...2)
                }
                
                
            }.foregroundStyle(.white)
            
            Spacer()
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background{
            RoundedRectangle(cornerRadius: 8).fill(backgroundFill)
        }
        
    }
    
    private var backgroundFill: AnyShapeStyle {
        if isPreview {
            return AnyShapeStyle(Color.rosaMedio)
        } else {
            return AnyShapeStyle(degradeRosa())
        }
    }
}

#Preview {
    MoodPreviewComponent(mood: .moreOrLess, entryDate: Date.now, isPreview: false)
}
