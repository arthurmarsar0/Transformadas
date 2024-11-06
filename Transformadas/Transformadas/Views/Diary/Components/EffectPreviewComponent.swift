//
//  EffectPreviewComponent.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 30/10/24.
//

import SwiftUI

// Layout personalizado para simular um HStack com quebra automática de linha
struct WrapHStackLayout: Layout {
    var spacing: CGFloat = 8  // Espaçamento entre itens
    var verticalSpacing: CGFloat = 8  // Espaçamento entre linhas

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var totalWidth: CGFloat = 0
        var totalHeight: CGFloat = 0
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity

        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            
            // Adiciona espaçamento entre itens
            if rowWidth + subviewSize.width + spacing > maxWidth {
                // Move para a próxima linha
                totalHeight += rowHeight + verticalSpacing
                totalWidth = max(totalWidth, rowWidth)
                
                // Reseta a largura da linha
                rowWidth = subviewSize.width
                rowHeight = subviewSize.height
            } else {
                // Adiciona o item à largura da linha atual
                if rowWidth > 0 {
                    rowWidth += spacing
                }
                rowWidth += subviewSize.width
                rowHeight = max(rowHeight, subviewSize.height)
            }
        }

        // Adiciona a última linha ao total
        totalHeight += rowHeight
        totalWidth = max(totalWidth, rowWidth)

        return CGSize(width: min(totalWidth, maxWidth), height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var rowHeight: CGFloat = 0
        let maxWidth = bounds.width

        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)

            // Quebra a linha se o próximo subview não couber na linha atual
            if xOffset + subviewSize.width > maxWidth {
                xOffset = 0
                yOffset += rowHeight + verticalSpacing
                rowHeight = 0
            }

            // Posiciona o subview
            subview.place(at: CGPoint(x: xOffset, y: yOffset), proposal: .init(width: subviewSize.width, height: subviewSize.height))
            
            // Atualiza os deslocamentos para o próximo subview
            xOffset += subviewSize.width + spacing
            rowHeight = max(rowHeight, subviewSize.height)
        }
    }
}

// Componente principal usando o layout personalizado com o EffectComponent
struct EffectPreviewComponent: View {
    var effects: [Effect]
    var isPreview: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !isPreview {
                Text("EFEITOS OBSERVADOS")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
            }

            WrapHStackLayout(spacing: 8, verticalSpacing: 8) {
                ForEach(effects, id: \.name) { effect in
                    EffectComponent(effect: effect, isPreview: isPreview)
                }
            }
            //.background(.rosa)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct EffectComponent: View {
    var effect: Effect
    var isPreview: Bool
    
    var body: some View {
        Text(effect.name)
            .font(.system(size: isPreview ? 11 : 16, weight: .regular))
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
    EffectPreviewComponent(effects: [Effect(name: "Crescimento das mamas", status: .active), Effect(name: "Diminuição de pelos faciais", status: .active), Effect(name: "Fadiga", status: .active), Effect(name: "Insônia", status: .active), Effect(name: "Náusea", status: .active), Effect(name: "Diminuição de pelos faciais", status: .active), Effect(name: "Diminuição de pelos faciais", status: .active)], isPreview: false)
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
