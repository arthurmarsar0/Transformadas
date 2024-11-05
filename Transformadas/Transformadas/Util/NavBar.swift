//
//  NavBar.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 02/11/24.
//

import SwiftUI

func addNavBarBackground() {
    changeNavBarBackground(image: .background)
}

func removeNavBarBackground() {
    changeNavBarBackground(image: nil)
}

func changeNavBarBackground(image: UIImage?) {
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = nil
    appearance.backgroundImage = image
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    
}

