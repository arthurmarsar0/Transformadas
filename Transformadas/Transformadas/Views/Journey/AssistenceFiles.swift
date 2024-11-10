//
//  AssistenceFiles.swift
//  Transformadas
//
//  Created by Arthur Alves Marsaro on 06/11/24.
//

import Foundation
import SwiftUI
import SwiftData


struct WeightData: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double
}
let UserTest = User.init(name: "Arthur", weight: 75.0, transitionStart: Date.now.addingTimeInterval(-86400 * 350), hormonalTherapyType: .feminization, pronouns: [])

let weightData = [
    WeightData(date: Date().addingTimeInterval(-86400 * 5), weight: 71.0),
    WeightData(date: Date().addingTimeInterval(-86400 * 4), weight: 70.8),
//    WeightData(date: Date().addingTimeInterval(-86400 * 3), weight: 71.2),
//    WeightData(date: Date().addingTimeInterval(-86400 * 2), weight: 70.7),
//    WeightData(date: Date().addingTimeInterval(-86400 * 1), weight: 70.4),
//    WeightData(date: Date(), weight: 70.0),
//    WeightData(date: Date().addingTimeInterval(86400 * 2), weight: 70.0),
    WeightData(date: Date().addingTimeInterval(86400 * 3), weight: 70.5)
]

let entradasMock = [
                Entry(date: Date.now.addingTimeInterval(-86400 * 15), mood: Mood.ok, note: "", audio: nil, photos: [], effects: [.init(name: "fadiga"), .init(name: "insonia")], documents: [], weight: 71.0),
                Entry(date: Date.now.addingTimeInterval(-86400 * 14), mood: Mood.bad, note: "", audio: nil, photos: [], effects: [.init(name: "fadiga"), .init(name: "insonia")], documents: [], weight: 70.7),
                Entry(date: Date.now.addingTimeInterval(-86400 * 1), mood: Mood.ok, note: "", audio: nil, photos: [], effects: [.init(name: "fadiga"), .init(name: "aumento de mamas")], documents: [], weight: 70.4),
                Entry(date: Date.now, mood: Mood.excellent, note: "", audio: nil, photos: [], effects: [], documents: [], weight: 70.0),
                Entry(date: Date.now.addingTimeInterval(86400 * 1), mood: Mood.ok, note: "", audio: nil, photos: [], effects: [.init(name: "aumento do pé"), .init(name: "insonia")], documents: [], weight: 70.6),
                Entry(date: Date.now.addingTimeInterval(86400 * 2), mood: Mood.bad, note: "", audio: nil, photos: [], effects: [.init(name: "sudorese"), .init(name: "insonia")], documents: [], weight: 70.5),
                Entry(date: Date.now.addingTimeInterval(86400 * 3), mood: Mood.ok, note: "", audio: nil, photos: [], effects: [.init(name: "fadiga"), .init(name: "diminuicao de pelos")], documents: [], weight: 70.7),
                Entry(date: Date.now.addingTimeInterval(86400*4), mood: Mood.well, note: "", audio: nil, photos: [], effects: [.init(name: "ansiedade"), .init(name: "insonia")], documents: [], weight: 70.8),
                Entry(date: Date.now.addingTimeInterval(86400 * 5), mood: Mood.ok, note: "", audio: nil, photos: [], effects: [.init(name: "fadiga"), .init(name: "ansiedade")], documents: [], weight: 71.4),
                Entry(date: Date.now.addingTimeInterval(86400 * 6), mood: Mood.moreOrLess, note: "", audio: nil, photos: [], effects: [.init(name: "febre"), .init(name: "insonia")], documents: [], weight: 72.0),
                Entry(date: Date.now.addingTimeInterval(86400 * 7), mood: Mood.ok, note: "", audio: nil, photos: [], effects: [.init(name: "fadiga"), .init(name: "Dor na orelha")], documents: [], weight: 71.5),
                Entry(date: Date.now.addingTimeInterval(86400 * 8), mood: Mood.excellent, note: "", audio: nil, photos: [], effects: [.init(name: "dor de cabeça"), .init(name: "insonia")], documents: [], weight: 71.3),
//                Entry(date: Date.now.addingTimeInterval(86400 * 9), mood: Mood.ok, note: "", audio: nil, photos: [], effects: [.init(name: "fadiga"), .init(name: "febre")], documents: "arquivo 1"),
//                Entry(date: Date.now.addingTimeInterval(86400 * 10), mood: Mood.ok, note: "", audio: "Audio 2", photos: "foto 2", effects: [.init(name: "fadiga"), .init(name: "febre")], documents: "arquivo 2"),
//                Entry(date: Date.now.addingTimeInterval(86400 * 11), mood: Mood.ok, note: "", audio: "audio 3", photos: "foto 3", effects: [.init(name: "fadiga"), .init(name: "calafrios")], documents: "arquivo 3"),
//                Entry(date: Date.now.addingTimeInterval(86400 * 12), mood: Mood.excellent, note: "", audio: "audio3", photos: "foto 4", effects: [.init(name: "calafrio"), .init(name: "insonia")], documents: "arquivo 4"),
//                Entry(date: Date.now.addingTimeInterval(86400 * 13), mood: Mood.well, note: "", audio: "audio 1", photos: "Foto 1", effects: [.init(name: "fadiga"), .init(name: "insonia")], documents: "arquivo 1"),
//                Entry(date: Date.now.addingTimeInterval(86400 * 14), mood: Mood.bad, note: "", audio: "Audio 2", photos: "foto 2", effects: [.init(name: "fadiga"), .init(name: "insonia")], documents: "arquivo 2"),
//                Entry(date: Date.now.addingTimeInterval(86400 * 15), mood: Mood.ok, note: "", audio: "audio 3", photos: "foto 3", effects: [.init(name: "fadiga"), .init(name: "insonia")], documents: "arquivo 3"),
//                Entry(date: Date.now.addingTimeInterval(86400 * 16), mood: Mood.excellent, note: "", audio: "audio3", photos: "foto 4", effects: [.init(name: "fadiga"), .init(name: "insonia")], documents: "arquivo 4")
]

func newDateFrom(aPartirDe data: Date, soma: Int) -> Date? {
    let calendar = Calendar.current

    return calendar.date(byAdding: .month, value: soma, to: data)
}

func gerarArrayDeMeses(aPartirDe dataInicial: Date, quantidade: Int) -> [String] {
    var meses: [String] = []
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy" // Formato: Nome do mês e ano (ex: Janeiro 2024)

    for i in 0..<quantidade {
        if let mes = calendar.date(byAdding: .month, value: -i, to: dataInicial) {
            let mesFormatado = dateFormatter.string(from: mes)
            meses.append(mesFormatado)
        }
    }

    return meses
}

func gerarArrayDeMesesComoData(aPartirDe dataInicial: Date, quantidade: Int) -> [Date] {
    var meses: [Date] = []
    let calendar = Calendar.current

    for i in 0..<quantidade {
        if let mes = calendar.date(byAdding: .month, value: i, to: dataInicial) {
            meses.append(mes)
        }
    }

    return meses
}
// Uso
var quantidade = 12
var meses = gerarArrayDeMeses(aPartirDe: Date(), quantidade: quantidade)

struct PaginatedView<Content: View>: View {
    var itemsPerPage: Int = 50
    @Binding var paginationOffset: Int?
    @ViewBuilder var content: ([Entry]) -> Content
    
    @State private var entriess: [Entry] = []
    @Environment(\.modelContext) private var context
    
    var body: some View {
        content(entriess)
            .onChange(of: paginationOffset, initial: false) { oldValue, newValue in
                do {
                    guard let newValue else { return }
                    
                    var descriptor = FetchDescriptor<Entry>()
                    
                    let totalCount = try context.fetchCount(descriptor)
                    
                    descriptor.fetchLimit = itemsPerPage
                    
                    let pageOffset = min(min(totalCount, newValue), entriess.count)
                    
                    if totalCount == entriess.count {
                        paginationOffset = totalCount
                    } else {
                        let newData = try context.fetch(descriptor)
                        entriess.append(contentsOf: newData)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

extension View {
    @ViewBuilder
    func customOnAppear(_ callOnce: Bool = true, action: @escaping () -> ()) -> some View {
        self
            .modifier(CustomOnAppearModifier(callOnce: callOnce, action: action))
    }
}

fileprivate struct CustomOnAppearModifier: ViewModifier {
    var callOnce: Bool
    var action: () -> ()
    
    @State private var isTriggered: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if callOnce {
                    if !isTriggered {
                        action()
                        isTriggered = true
                    }
                } else {
                    action()                }
            }
    }
    
}

