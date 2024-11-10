//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import Charts
import SwiftData

struct Journey: View {
    
    // MARK: - DATA
    @Environment(\.modelContext) var modelContext
    @Query var allEntries: [Entry]
    
    // MARK: - View Data
    @State private var selectedFeelingsDate: Date = Date.now
    @State private var selectedEffectsDate: Date = Date.now
    @State private var selectedWeightDate: Date = Date.now
    @State private var showFeelingsPicker: Bool = false
    @State private var showEffectsPicker: Bool = false
    @State private var showWeightPicker: Bool = false
    @State private var calendar = Calendar.current // variável usada para calcular os dias só
    @State var effectsGraphsFullView: Bool = false
    
    var daysSinceStartOfTransition: Int {
        if UserTest.transitionStart != nil {
            return calendar.numberOfDays(from: UserTest.transitionStart!, to: Date.now)
        } else {
            return 0
        }
    }
    
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
                            effectsGraphsFullView.toggle()
                        }) {
                            efectsCharts()
                        }
                        
                        weightChart()
                        
                    }
                    .padding()
                }
                
                if showFeelingsPicker {
                    Color.black.opacity(0.4) // Fundo semi-transparente
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showFeelingsPicker = false // Fechar picker ao tocar no fundo
                        }
                    
                    MonthYearPicker(selectedDate: $selectedFeelingsDate)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 300, height: 250)
                        .shadow(radius: 10)
                        .padding(.horizontal, 30)
                }
                
                if showEffectsPicker {
                    Color.black.opacity(0.4) // Fundo semi-transparente
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showEffectsPicker = false // Fechar picker ao tocar no fundo
                        }
                    
                    MonthYearPicker(selectedDate: $selectedEffectsDate)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 300, height: 250)
                        .shadow(radius: 10)
                        .padding(.horizontal, 30)
                }
                
                if showWeightPicker {
                    Color.black.opacity(0.4) // Fundo semi-transparente
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showWeightPicker = false // Fechar picker ao tocar no fundo
                        }
                    
                    MonthYearPicker(selectedDate: $selectedWeightDate)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 300, height: 250)
                        .shadow(radius: 10)
                        .padding(.horizontal, 30)
                }
                
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
            .animation(.smooth, value: effectsGraphsFullView)
            
        }
        
    }
    
    func transversaryView() -> some View {
        HStack{
            VStack(alignment: .leading){
                HStack(alignment: .bottom){
                    Text(String(daysSinceStartOfTransition))
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
    }
    
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
        
        var monthEntriesFeeling : [Entry] {
            var array : [Entry] = []

            for i in allEntries {
                if i.date.monthNumber == selectedFeelingsDate.monthNumber && i.date.yearNumber == selectedFeelingsDate.yearNumber {
                    array.append(i)
                }
            }
            return array
        }
        
        return ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(.begeClaro)
            VStack{
                HStack{
                    Text("Sentimentos")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.gray)
                    Spacer()
                    Button(action: {
                        showFeelingsPicker.toggle()
                    }){
                        Text(selectedFeelingsDate.monthString.capitalized.prefix(3) + " " + String(selectedFeelingsDate.yearNumber))
                            .foregroundStyle(.azul)
                    }
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.accentColor.opacity(0.12))
                    }
                }
                
                Chart(monthEntriesFeeling, id: \.self) { entry in
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
                    .foregroundStyle(LinearGradient(colors: [Color.rosa.opacity(0.2), Color.clear], startPoint: .top, endPoint: .bottom))
                }
                        .padding(.top, 12)
                        .foregroundStyle(.rosa)
                        .frame(height: 312)
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
        var monthEntriesEffects : [Entry] {
            var array : [Entry] = []

            for i in allEntries {
                if i.date.monthNumber == selectedEffectsDate.monthNumber && i.date.yearNumber == selectedEffectsDate.yearNumber {
                    array.append(i)
                }
            }
            return array
        }
        
        var monthlyEffects : [String : Int] {
            var emptyDict: [String: Int] = [:]
            
            for entrada in monthEntriesEffects {
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
        
        var sizeOfReturn: Int {
            if effectsGraphsFullView {
                0
            } else {
                if monthlyEffects.count > 5 {
                    monthlyEffects.count - 5
                } else {
                    0
                }
            }
        }
        
        var sizeOfGraph: CGFloat {
            if effectsGraphsFullView {
                CGFloat(monthlyEffects.count * 54)
            } else {
                CGFloat(296)
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
                    Button(action: {
                        showEffectsPicker.toggle()
                    }){
                        Text(selectedEffectsDate.monthString.capitalized.prefix(3) + " " + String(selectedEffectsDate.yearNumber))
                            .foregroundStyle(.vermelho)
                    }
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.rosa.opacity(0.12))
                    }
                    
                }
                
                Chart(monthlyEffects.keys.sorted().dropLast(sizeOfReturn), id: \.self) { efeito in
                    BarMark(
                        x: .value("qntd", monthlyEffects[efeito] ?? 0),
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
    
    func weightChart() -> some View {       //TODO: Peso ainda não colocado no registro, adicionar aqui quando atualizar
        
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(.begeClaro)
            
            VStack{
                HStack{
                    Text("Peso")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.cinzaEscuro)
                    Spacer()
                    Button(action: {
                        showWeightPicker.toggle()
                    }){
                        Text(selectedWeightDate.monthString.capitalized.prefix(3) + " " + String(selectedWeightDate.yearNumber))
                    }
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.accentColor.opacity(0.12))
                    }
                }
                Chart(weightData) { entry in
                    
                    LineMark(
                        x: .value("Dia", entry.date),
                        y: .value("Peso", entry.weight)
                    )
                    .foregroundStyle(.rosa)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .shadow(radius: 10)
                    
                }
                .chartYScale(domain: [68,72])  //Colocar uma valor que pegue uma margem de erro do maior e menor valor (pensei em algo como +- 2
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) {
                        AxisValueLabel(format: .dateTime.day())
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
        .modelContainer(for: [Effect.self,
                              User.self,
                              Entry.self,
                              Reminder.self], inMemory: true, isAutosaveEnabled: false)
}
