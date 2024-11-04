//
//  ListView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//


import SwiftUI

struct ListView: View {
    @State var isSheetPresented: Bool = false
    @StateObject var viewModel = ServiceViewModel()
    @Binding var selectedFilter: String 
    @State var selectedService: Service?

    var body: some View {
        CategoryFilter(selectedFilter: $selectedFilter)
        VStack {
            ScrollView(.vertical) {
                ForEach(0 ..< viewModel.filteredServices.count, id: \.self) { index in
                    let service = viewModel.filteredServices[index]
                    
                    Button(action: {
                        selectedService = service
                        isSheetPresented.toggle()
                    }) {
                        ListComponent(service: service)
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        if let service = selectedService{
                            SheetDetailView(service: service)
                        }
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

