//
//  ServicesViewModel.swift
//  Transformadas
//
//  Created by Alice Barbosa on 03/11/24.
//

import SwiftUI
import Combine

class ServiceViewModel: ObservableObject {
    @Published var allServices: [Service] = []
    @Published var filteredServices: [Service] = []
    
    func loadServices() async {
        do {
            allServices = try await ServiceModel.getServices()
            filteredServices = allServices // Inicialmente, todos os serviços são filtrados
        } catch {
            print("Erro ao carregar serviços: \(error)")
        }
    }
    
    
    func filterServices(by category: String) {
        if category == "Todos" {
            filteredServices = allServices // Retorna todos os serviços se "Todos" for selecionado
        } else {
            filteredServices = allServices.filter { service in
                service.categories.contains { $0.name == category }
            }
        }
    }
}
