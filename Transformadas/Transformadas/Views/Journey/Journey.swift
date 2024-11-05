//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import Charts
import UIKit

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
                Entry(date: Date.now, mood: Mood.excellent, note: "", audio: "audio3", photo: "foto 4", effects: [], pdf: "arquivo 4")]

struct Journey: View {

//    @State var selectedMonthHumor: Date = Date()
    @State var selectedMonthEfects: Date = Date()
    @State var selectedMonthWeight: Date = Date()
    
    let datePicker = UIDatePicker()
    //datePicker.datePickerMode = .yearAndMonth
    //datePicker.preferredDatePickerStyle = .wheels
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bege
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        transversaryView()
                        buttonsView()
                        feelingsCharts()
                        efectsCharts()
                        weightChart()
                        
                    }
                    .padding()
                }
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading){
                        Text("Jornada")
                            .font(.system(size: 28, weight: .semibold))
                        
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            
                        }) {
                            Image(systemName: "calendar")
                                .foregroundStyle(.black)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            
                        }) {
                            Image(systemName: "ellipsis.circle")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
        
    }
    
    func transversaryView() -> some View {
        HStack{
            VStack(alignment: .leading){
                HStack(alignment: .bottom){
                    Text("1204")
                        .font(.system(size:28 , weight: .semibold))
                    Text("DIAS")
                        .font(.system(size: 22, weight: .semibold))
                }
                .foregroundStyle(degradeRosa2())
                
                Text("Em transição")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.marrom)
            }
            Spacer()
            Image("Butterfly")
        }
    } //TODO: Transversário ainda está algo estático, ver como vai ser o banco para fazer algo adaptativo
    
    func buttonsView() -> some View {
        HStack(spacing: 8){
            Button(action:{
                print("fotos")
            }) {
                HStack{
                    VStack(alignment: .leading){
                        Image(systemName: "photo.on.rectangle.angled.fill")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                        Text("Minhas Fotos")
                            .font(.system(size: 17, weight: .medium))
                    }
                    .foregroundStyle(.azul)
                    
                    Spacer()
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.verdeClaro)
            }
                
            
            
            Button(action:{
                print("audios")
            }) {
                HStack{
                    VStack(alignment: .leading){
                        Image(systemName: "waveform")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                        Text("Meus")
                            .font(.system(size: 17, weight: .medium))
                        Text("Audios")
                            .font(.system(size: 17, weight: .medium))
                    }
                    .foregroundStyle(.vermelho)
                    
                    Spacer()
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.rosaClaro)
            }
            
            Button(action:{
                print("audios")
            }) {
                HStack{
                    VStack(alignment: .leading){
                        Image(systemName: "document.fill")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                        Text("Meus")
                            .font(.system(size: 17, weight: .medium))
                        Text("Arquivos")
                            .font(.system(size: 17, weight: .medium))
                    }
                    .foregroundStyle(.cinzaEscuro)
                    
                    Spacer()
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultrathin.opacity(0.44))
            }
        }
    }
    
    func feelingsCharts() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(.begeClaro)
            VStack{
                HStack{
                    Text("Sentimentos")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.gray)
                    Spacer()
                    
                }
                Chart(entradasMock, id: \.self) { entrada in
                    LineMark(
                        x: .value("Data", entrada.date),
                        y: .value("Mood", entrada.mood?.emoji ?? "")
                    )
                }
//                .chartYScale{
                    
//                }
                
            }
            .padding()
        }
    }
    
    func efectsCharts() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(.begeClaro)
            VStack{
                HStack{ //TODO: Ver se fica melhor com Group
                    Text("Efeitos")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                    
                        
                }
                Chart(efeitoss) { efeito in
                    BarMark(
                        x: .value("qntd", efeito.count),
                        y: .value("Nome", efeito.name)
                    )
                    .cornerRadius(6)
                }
                .foregroundStyle(LinearGradient(colors: [.white,.azul], startPoint: .leading, endPoint: .trailing))
                
            }
            .padding()
        }
        .frame(minHeight: 272)
    }
    
    func weightChart() -> some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(.begeClaro)
            
            VStack{
                HStack{ //TODO: Ver se fica melhor com Group
                    Text("Peso")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                    Text("data") //TODO: alterar para picker
                }
                Chart(weightData) { entry in
                    
                    LineMark(
                        x: .value("Dia", entry.date),
                        y: .value("Peso", entry.weight)
                    )
                    .foregroundStyle(.rosa)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .shadow(radius: 10)
                    
                    
//                    .interpolationMethod(.catmullRom)
                    
//                    AreaMark(
//                        x: .value("Dia", entry.date),
//                        y: .value("Peso", entry.weight)
//                    )
//                    .foregroundStyle(
//                        LinearGradient(colors: [Color.rosa.opacity(0.2), Color.clear], startPoint: .top, endPoint: .bottom)
//                    )
//                    .interpolationMethod(.catmullRom)
                }
                .chartYScale(domain: [68,72]) // Define o limite do eixo Y, ajustando conforme necessário
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) {
                        AxisValueLabel(format: .dateTime.day()) //mostra apenas o dia
                    }
                }
                .frame(height: 272)
//                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    Journey()
}
