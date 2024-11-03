////
////  ListView.swift
////  Transformadas
////
////  Created by Alice Barbosa on 29/10/24.
////
//
//import SwiftUI
//
//struct ListView: View {
//    @State var isSheetPresented: Bool = false
//    @State var services: [Service] = []
//    var body: some View {
//        VStack{
//            ScrollView(.vertical){
//                ForEach(services , id: \.id){ service in
//                
//                    Button(action: {
//                        isSheetPresented.toggle()
//                    }){
//                        ListComponent(service: service)
//                    }
//                    
//                    .sheet(isPresented: $isSheetPresented){
//                        SheetDetailView(service: service)
//                    }
//                }
//                
//            }
//            .onAppear(){
//                Task {
//                    do{
//                        services = try await ServiceModel.getServices()
//                    }catch{
//                        print("Erro ao carregar serviços: \(error)")
//                    }
//                    
//                }
//            }
//            
//            //TODO: Adicionar lógica pra ForEach service in services etc com cloudkit e cada componente ser um botão que abre uma sheet
//        }.padding()
//    }
//}
//
//#Preview {
//    ListView()
//}

import SwiftUI

struct ListView: View {
    @State var isSheetPresented: Bool = false
    @State var services: [Service] = []

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(0 ..< services.count, id: \.self) { index in
                    let service = services[index]
                    
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        ListComponent(service: service)
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        SheetDetailView(service: service)
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        services = try await ServiceModel.getServices()
                    } catch {
                        print("Erro ao carregar serviços: \(error)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ListView()
}
