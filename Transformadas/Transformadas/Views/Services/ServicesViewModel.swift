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
    
    func filterServices(by category: String) {
        if category == "Todos" {
            filteredServices = allServices
        } else {
            filteredServices = allServices.filter { service in
                service.categories.contains { $0.name == category }
            }
        }
    }
    
    
}
