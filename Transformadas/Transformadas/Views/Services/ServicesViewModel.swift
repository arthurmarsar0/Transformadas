//
//  ServicesViewModel.swift
//  Transformadas
//
//  Created by Alice Barbosa on 03/11/24.
//

import SwiftUI
import Combine

@MainActor
class ServiceViewModel: ObservableObject {
    @Published var allServices: [Service] = []
    @Published var filteredServices: [Service] = []
    @Published var selectedFilter: String = "Todos"

    
    
    
    func loadServices() async {

        do {
            
            allServices = try await ServiceModel.getServices()
            filteredServices = allServices

        } catch {
            print("Erro ao carregar serviços: \(error)")
        }
    }
    
    
    func filterServices(by category: String, searchText: String) {
        filteredServices = allServices.filter { service in
            // Filtra pela categoria, se selecionada, e pelo nome do serviço
            let matchesCategory = category == "Todos" || service.categories.contains { $0.name == category }
            let matchesSearchText = searchText.count < 3 || service.name.localizedCaseInsensitiveContains(searchText)
            
            return matchesCategory && matchesSearchText
        }
        filteredServices.sort { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    
}
