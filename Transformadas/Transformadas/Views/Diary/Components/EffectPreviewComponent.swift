//
//  EffectPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

struct EffectPreviewComponent: View {
    var effects: [Effect]
    var isReduced: Bool
        
    var maxWidth: CGFloat {
        isReduced ? 164.5 : 337
    }

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    // Agrupamos os itens por linhas para que cada linha respeite o limite de largura
                    ForEach(groupedEffects, id: \.self) { rowEffects in
                        HStack(spacing: 8) {
                            ForEach(rowEffects, id: \.name) { effect in
                                EffectComponent(effect: effect)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        
        var groupedEffects: [[Effect]] {
            var rows: [[Effect]] = []
            var currentRow: [Effect] = []
            var currentRowWidth: CGFloat = 0

            for effect in effects {
                let effectWidth = estimateEffectWidth(effect) + 16

                if currentRowWidth + effectWidth > maxWidth {
                    
                    rows.append(currentRow)
                    currentRow = [effect]
                    currentRowWidth = effectWidth
                } else {
                    
                    currentRow.append(effect)
                    currentRowWidth += effectWidth + 8
                }
            }

            if !currentRow.isEmpty {
                rows.append(currentRow)
            }

            return rows
        }

        func estimateEffectWidth(_ effect: Effect) -> CGFloat {
            let font = UIFont.systemFont(ofSize: 11, weight: .regular)
            let attributes = [NSAttributedString.Key.font: font]
            let size = (effect.name as NSString).size(withAttributes: attributes)
            return size.width
        }
    
}

struct EffectComponent: View {
    var effect: Effect
    
    var body: some View {
        Text(effect.name)
            .font(.system(size: 11, weight: .regular))
            .foregroundStyle(.vermelho)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.vermelho.opacity(0.1))
            }.fixedSize()
        
    }
}

#Preview {
    EffectPreviewComponent(effects: [Effect(name: "Crescimento das mamas"), Effect(name: "Diminuição de pelos faciais"), Effect(name: "Fadiga"), Effect(name: "Insônia"), Effect(name: "Náusea")], isReduced: true)
}
