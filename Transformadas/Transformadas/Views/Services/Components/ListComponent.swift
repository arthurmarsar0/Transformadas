//
//  ListComponent.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import CoreLocation

struct ListComponent: View {
    func distanceInKilometers(from coordinate1: CLLocationCoordinate2D, to coordinate2: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        
        let distanceInMeters = location1.distance(from: location2)
        return distanceInMeters / 1000.0 // Converte de metros para quilômetros
    }
    var service: Service
    @State private var locationManager = LocationManager()
    var body: some View {
        ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 8)
                .frame(height: 128)
                .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        ForEach(service.categories , id: \.self) { category in
                            if !category.symbol.isEmpty{
                                Image(systemName: category.symbol)
                                    .foregroundStyle(category.color)
                            }
                        }
                    }
                    Text(service.name)
                        .foregroundColor(.preto)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .lineLimit(1)
                        
                    Text(service.address.street + " " + service.address.neighborhood)
                        .foregroundColor(.cinzaEscuro)
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .lineLimit(1)
                    if let userCoordinate = locationManager.userLocation?.coordinate {
                        Text(String(format: "%.2f km", distanceInKilometers(from: userCoordinate, to: service.coordinate)))
                            .foregroundColor(.cinzaEscuro)
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .lineLimit(1)
                        
                    } else {
                        Text("Carregando...")
                            .foregroundColor(.cinzaEscuro)
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .lineLimit(1)
                    }
                }
                .padding()
        }
    }
}

