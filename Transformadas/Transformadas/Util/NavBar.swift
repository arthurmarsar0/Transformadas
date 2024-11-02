//
//  NavBar.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 02/11/24.
//

import SwiftUI

struct NavigationBarWithImageBackgroundModifier: ViewModifier {
    var backgroundImage: UIImage

    init(backgroundImage: UIImage) {
        self.backgroundImage = backgroundImage
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .bege
        appearance.backgroundImage = backgroundImage
        
        // Aplicando o estilo com imagem para todas as aparências da NavigationBar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}

func createWhiteImage(size: CGSize) -> UIImage {
    // Começa um novo contexto gráfico com a largura e altura especificadas
    UIGraphicsBeginImageContext(size)
    
    // Define a cor de preenchimento como branco
    UIColor.white.setFill()
    
    // Preenche um retângulo com a cor branca
    let rect = CGRect(origin: .zero, size: size)
    UIRectFill(rect)
    
    // Captura a imagem do contexto
    let whiteImage = UIGraphicsGetImageFromCurrentImageContext()
    
    // Finaliza o contexto gráfico
    UIGraphicsEndImageContext()
    
    return whiteImage ?? UIImage()
}

extension View {
    func navigationBarWithImageBackground(_ backgroundImage: UIImage) -> some View {
        self.modifier(NavigationBarWithImageBackgroundModifier(backgroundImage: backgroundImage))
    }
}
