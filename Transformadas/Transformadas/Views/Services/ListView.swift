//
//  ListView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//


import SwiftUI

struct ListView: View {
    @State var isSheetPresented: Bool = false
    @State var filteredServices: [Service] = []
    @StateObject var viewModel = ServiceViewModel()
    var selectedFilter: String

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(0 ..< viewModel.filteredServices.count, id: \.self) { index in
                    let service = viewModel.filteredServices[index]
                    
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
                    await viewModel.loadServices()
                    viewModel.filterServices(by: selectedFilter)
                }
            }
            .onChange(of: selectedFilter){
                viewModel.filterServices(by: selectedFilter)
            }
        }
        .padding()
    }
}
//
//#Preview {
//    ListView()
//}
