//
//  SplashScreen.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 07/11/24.
//

import SwiftUI

struct SplashScreen: View {
    @State var splashScreen = true
    
    var body: some View {
        if splashScreen {
            ZStack {
                Color.bege
                    .ignoresSafeArea()
                Image(.splashScreen)
            }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            splashScreen = false
                        }
                    }
                }
        } else {
            ContentView()
        }
        
    }
}
