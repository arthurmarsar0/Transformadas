//
//  Gradient.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 29/10/24.
//

import SwiftUI

func degradeRosa() -> LinearGradient {
    return LinearGradient(
        gradient: Gradient(stops: [
            //.init(color: .white, location: 0.0),
            //.init(color: .rosaClaro, location: 0.22),
            .init(color: .rosaDoGradiente, location: 0.0),
            .init(color: .rosa, location: 0.5),
            .init(color: .rosa, location: 1)
        ]),
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
}

func degradeRosa2() -> LinearGradient {
    return LinearGradient(
        gradient: Gradient(stops: [
            //.init(color: .white, location: 0.0),
            //.init(color: .rosaClaro, location: 0.22),
            .init(color: .rosaDoGradiente, location: 0.0),
            .init(color: .rosa, location: 0.5),
            .init(color: .rosa, location: 1)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
}

