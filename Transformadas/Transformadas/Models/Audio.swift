//
//  Audio.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 06/11/24.
//

import Foundation

struct Audio: Identifiable, Equatable, Codable {
    let id = UUID()
    var name: String
    var path: URL
    var length: TimeInterval
}
