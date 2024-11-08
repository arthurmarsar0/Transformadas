//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import Charts

struct Journey: View {

//    @State var selectedMonthHumor: Date = Date()
    @State private var selectedMonthFeelings: String = Date.now.monthString
    @State private var selectedYearFeelings: Int = Date.now.yearNumber
    
    let datePicker = UIDatePicker()
    //datePicker.datePickerMode = .yearAndMonth
    //datePicker.preferredDatePickerStyle = .wheels
    
    var monthlyFeeeling : [String : Int] {
        var emptyDict: [String: Int] = [:]
        
        for entrada in entradasMock {
            if let effects = entrada.effects {
                for efeitos in effects {
                    var quant : Int = emptyDict[efeitos.name] ?? 0
                    quant += 1
                    emptyDict[efeitos.name] = quant
                }
            }
        }
        
        return emptyDict
    }
    
    @State var effectsGraphsFullView: Bool = false
    
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
                        
                        Button(action: {
                            print("Teste chart")
                            effectsGraphsFullView.toggle()
                        }) {
                            efectsCharts()
                        }
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
            NavigationLink(destination: PhotoAlbumView()
                ) {
                HStack{
                    VStack(alignment: .leading){
                        Image(systemName: "photo.on.rectangle.angled.fill")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                        Text("Minhas")
                            .font(.system(size: 17, weight: .medium))
                        Text("Fotos")
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
                
            
            
            NavigationLink(destination: AllAudiosView()
                ) {
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
        
            NavigationLink(destination: AllDocumentsView()) {
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
        var sizeOfReturn: Int {
            if effectsGraphsFullView {
                0
            } else {
                monthlyFeeeling.count - 5
            }
        }
        
        var sizeOfGraph: CGFloat {
            if effectsGraphsFullView {
                CGFloat(monthlyFeeeling.count * 54)
            } else {
                CGFloat(272)
            }
        }
        
        return ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(.begeClaro)
            VStack{
                HStack{
                    Text("Efeitos")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                    
                        
                }
                
                //TODO: efeitoss vai ser o resultado do fetch das entradas do mês
               
                Chart(monthlyFeeeling.keys.sorted().dropLast(sizeOfReturn), id: \.self) { efeito in
                    BarMark(
                        x: .value("qntd", monthlyFeeeling[efeito] ?? 0),
                        y: .value("Nome", efeito)
                    )
                    .cornerRadius(6)
                }
                .foregroundStyle(LinearGradient(colors: [.clear,.azul], startPoint: .leading, endPoint: .trailing))
                
            }
            .padding()
        }
        .frame(minHeight: sizeOfGraph)
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
