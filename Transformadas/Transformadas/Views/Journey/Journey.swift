//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import Charts
import UIKit

struct Journey: View {

//    @State var selectedMonthHumor: Date = Date()
    @State private var selectedMonthFeelings: String = Date.now.monthString
    @State private var selectedYearFeelings: Int = Date.now.yearNumber
    
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
                        
                        MonthYearPickerView(selectedMonth: $selectedMonthFeelings, selectedYear: $selectedYearFeelings)
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
                    Button(action: {
                        
                    }){
                        Text(selectedMonthFeelings.prefix(3) + " " + String(selectedYearFeelings))
                    }
                }
//                Chart(entradasMock, id: \.self) { entrada in
//                    LineMark(
//                        x: .value("Data", entrada.date),
//                        y: .value("Mood", entrada.mood!.emoji)
//                    )
//                }
                
                Chart(entradasMock, id: \.self) { entry in
                            LineMark(
                                x: .value("Dia", entry.date),
                                y: .value("Sentimento", entry.mood!.rawValue)
                            )
                    
                            PointMark(
                                x: .value("Dia", entry.date),
                                y: .value("Sentimento", entry.mood!.rawValue)
                            )
                            
                            AreaMark(
                                x: .value("Dia", entry.date),
                                y: .value("Sentimento", entry.mood!.rawValue)
                            )
                            .foregroundStyle(LinearGradient(colors: [Color.rosa.opacity(0.2), Color.clear], startPoint: .top, endPoint: .bottom)) //TODO: Transformar nisso em uma função
                    
//                            .annotation(position: .top) {
//                                Text(entry.mood!.emoji)
//                                    .font(.system(size: 24)) // Tamanho do emoji
//                            }
                        }
                        .foregroundStyle(.rosa)
                        .frame(height: 300)
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day)) {
                                AxisValueLabel(format: .dateTime.day())
                            }
                        }
                        .chartYAxis {
                            AxisMarks(values: Mood.allCases.map { $0.rawValue }) { value in
                                if let mood = Mood(rawValue: value.as(Int.self) ?? 1) {
                                    AxisGridLine()
                                    AxisValueLabel(mood.emoji)
                                        .font(.system(size: 15))// Mostra o emoji no eixo Y
                                }
                            }
                        }
                
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
                .foregroundStyle(LinearGradient(colors: [.clear,.azul], startPoint: .leading, endPoint: .trailing))
                
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
