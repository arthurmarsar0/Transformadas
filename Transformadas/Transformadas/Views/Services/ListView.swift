//
//  ListView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//


import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ServiceViewModel()
    @Binding var selectedFilter: String 
    @State var selectedService: Service?
    @State var searchText: String = ""

    var body: some View {
        VStack {
            ServiceFilter(searchText: $searchText)
            CategoryFilter(selectedFilter: $selectedFilter)
            ScrollView(.vertical) {
                ForEach(0 ..< viewModel.filteredServices.count, id: \.self) { index in
                    let service = viewModel.filteredServices[index]
                    
                    Button(action: {
                        selectedService = service
                    }) {
                        ListComponent(service: service)
                    }

                }
                .sheet(item: $selectedService) { service in
                    SheetDetailView(service: service)
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadServices()
                    viewModel.filterServices(by: selectedFilter, searchText: searchText)
                }
            }
            .onChange(of: selectedFilter){
                viewModel.filterServices(by: selectedFilter, searchText: searchText)
                selectedService = nil
            }
            .onChange(of: searchText) {
                viewModel.filterServices(by: selectedFilter, searchText: searchText)
            }
        }
        .padding()
    }
}

