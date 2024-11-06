//
//  AssistenceFiles.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 06/11/24.
//

import Foundation

struct efeitoTeste: Identifiable {
    var id: UUID = UUID()
    
    var name: String
    var count: Int
}

let efeitoss: [efeitoTeste] = [efeitoTeste(name: "fadiga", count: 10), efeitoTeste(name: "Aumento das mamas", count: 20), efeitoTeste(name: "Ansiedade", count: 10), efeitoTeste(name: "Diminuição pelos faciais", count: 8), efeitoTeste(name: "Sudorese", count: 13)]

struct WeightData: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double
}

let weightData = [
    WeightData(date: Date().addingTimeInterval(-86400 * 5), weight: 71.0),
    WeightData(date: Date().addingTimeInterval(-86400 * 4), weight: 70.8),
    WeightData(date: Date().addingTimeInterval(-86400 * 3), weight: 71.2),
    WeightData(date: Date().addingTimeInterval(-86400 * 2), weight: 70.7),
    WeightData(date: Date().addingTimeInterval(-86400 * 1), weight: 70.4),
    WeightData(date: Date(), weight: 70.0),
    WeightData(date: Date().addingTimeInterval(86400 * 2), weight: 70.0),
    WeightData(date: Date().addingTimeInterval(86400 * 3), weight: 70.5)
]

let entradasMock = [
                Entry(date: Date.now.addingTimeInterval(-86400 * 3), mood: Mood.ok, note: "", audio: "audio 1", photo: "Foto 1", effects: [], pdf: "arquivo 1"),
                Entry(date: Date.now.addingTimeInterval(-86400 * 2), mood: Mood.bad, note: "", audio: "Audio 2", photo: "foto 2", effects: [], pdf: "arquivo 2"),
                Entry(date: Date.now.addingTimeInterval(-86400 * 1), mood: Mood.ok, note: "", audio: "audio 3", photo: "foto 3", effects: [], pdf: "arquivo 3"),
                Entry(date: Date.now, mood: Mood.excellent, note: "", audio: "audio3", photo: "foto 4", effects: [], pdf: "arquivo 4"),
                Entry(date: Date.now.addingTimeInterval(86400 * 1), mood: Mood.ok, note: "", audio: "audio 1", photo: "Foto 1", effects: [], pdf: "arquivo 1"),
                Entry(date: Date.now.addingTimeInterval(86400 * 2), mood: Mood.bad, note: "", audio: "Audio 2", photo: "foto 2", effects: [], pdf: "arquivo 2"),
                Entry(date: Date.now.addingTimeInterval(86400 * 3), mood: Mood.ok, note: "", audio: "audio 3", photo: "foto 3", effects: [], pdf: "arquivo 3"),
                Entry(date: Date.now.addingTimeInterval(86400*4), mood: Mood.well, note: "", audio: "audio3", photo: "foto 4", effects: [], pdf: "arquivo 4"),
                Entry(date: Date.now.addingTimeInterval(86400 * 5), mood: Mood.ok, note: "", audio: "audio 1", photo: "Foto 1", effects: [], pdf: "arquivo 1"),
                Entry(date: Date.now.addingTimeInterval(86400 * 6), mood: Mood.moreOrLess, note: "", audio: "Audio 2", photo: "foto 2", effects: [], pdf: "arquivo 2"),
                Entry(date: Date.now.addingTimeInterval(86400 * 7), mood: Mood.ok, note: "", audio: "audio 3", photo: "foto 3", effects: [], pdf: "arquivo 3"),
                Entry(date: Date.now.addingTimeInterval(86400 * 8), mood: Mood.excellent, note: "", audio: "audio3", photo: "foto 4", effects: [], pdf: "arquivo 4"),
                Entry(date: Date.now.addingTimeInterval(86400 * 9), mood: Mood.ok, note: "", audio: "audio 1", photo: "Foto 1", effects: [], pdf: "arquivo 1"),
                Entry(date: Date.now.addingTimeInterval(86400 * 10), mood: Mood.ok, note: "", audio: "Audio 2", photo: "foto 2", effects: [], pdf: "arquivo 2"),
                Entry(date: Date.now.addingTimeInterval(86400 * 11), mood: Mood.ok, note: "", audio: "audio 3", photo: "foto 3", effects: [], pdf: "arquivo 3"),
                Entry(date: Date.now.addingTimeInterval(86400 * 12), mood: Mood.excellent, note: "", audio: "audio3", photo: "foto 4", effects: [], pdf: "arquivo 4"),
                Entry(date: Date.now.addingTimeInterval(86400 * 13), mood: Mood.well, note: "", audio: "audio 1", photo: "Foto 1", effects: [], pdf: "arquivo 1"),
                Entry(date: Date.now.addingTimeInterval(86400 * 14), mood: Mood.bad, note: "", audio: "Audio 2", photo: "foto 2", effects: [], pdf: "arquivo 2"),
                Entry(date: Date.now.addingTimeInterval(86400 * 15), mood: Mood.ok, note: "", audio: "audio 3", photo: "foto 3", effects: [], pdf: "arquivo 3"),
                Entry(date: Date.now.addingTimeInterval(86400 * 16), mood: Mood.excellent, note: "", audio: "audio3", photo: "foto 4", effects: [], pdf: "arquivo 4")]
