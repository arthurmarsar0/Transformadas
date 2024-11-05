//
//  Samples.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 03/11/24.
//

import Foundation

extension EntryModel {
    static var samples: [Entry] {
        [
        Entry(date: Date.now, mood: .bad, note: "Dia ruim", audio: "", photos: [EntryModel.imageToData(image: .foto1)!, EntryModel.imageToData(image: .foto2)!], effects: [Effect(name: "Crescimento das mamas"), Effect(name: "Diminuição de pelos faciais"), Effect(name: "Fadiga")], documents: ["Doc1", "Doc2"], weight: 70.0),
         Entry(date: Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? Date.now, mood: .excellent, note: "Dia bom", audio: nil, photos: [EntryModel.imageToData(image: .foto3)!, EntryModel.imageToData(image: .foto4)!], effects: [Effect(name: "Crescimento das mamas"), Effect(name: "Diminuição de pelos faciais"), Effect(name: "Fadiga"), Effect(name: "Insônia"), Effect(name: "Náusea")], documents: ["Doc1", "Doc2"], weight: 71.1)
            
        ]
    }
}

extension EffectModel {
    static var samples: [Effect] {
        [
        Effect(name: "Crescimento das mamas"),
         Effect(name: "Diminuição de pelos faciais"),
         Effect(name: "Fadiga"),
         Effect(name: "Insônia"),
         Effect(name: "Náusea")
        ]
         
    }
}

extension ReminderModel {
    static var samples: [Reminder] {
        [
            Reminder(name: "Consulta Endocrinologista", startDate: Date.now, repetition: .never, type: .event, time: Date.now, daysCompleted: [], notes: "", dosage: "2mg"),
            Reminder(name: "Testosterona", startDate: Date.now, repetition: .daily, type: .medicine, time: Date.now, daysCompleted: [], notes: "", dosage: "2mg")
        ]
    }
}
