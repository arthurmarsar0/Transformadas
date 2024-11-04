//
//  Journey.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import Charts

struct efeitoTeste: Identifiable {
    var id: UUID = UUID()
    
    var name: String
    var count: Int
}

let efeitoss: [efeitoTeste] = [efeitoTeste(name: "fadiga", count: 10), efeitoTeste(name: "Aumento das mamas", count: 20), efeitoTeste(name: "Ansiedade", count: 10), efeitoTeste(name: "Diminuição pelos faciais", count: 8), efeitoTeste(name: "Sudorese", count: 13)]


struct Journey: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bege
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        transversaryView()
                        buttonsView()
                        
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
        HStack(spacing: 16){
            Button(action:{
                print("fotos")
            }) {
                HStack{
                    VStack(alignment: .leading){
                        Image(systemName: "photo.on.rectangle.angled.fill")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                        Text("Suas Fotos")
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
                        Text("Seus Áudios")
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
                    Text("data") //TODO: alterar para picker
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
        }
    }
}

#Preview {
    Journey()
}
