//
//  MapView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            if(locationManager.isAuthorized){
                Map(){
                    UserAnnotation()
                }.mapControls {
                    MapUserLocationButton()
                }
            }
        }.onAppear {
            locationManager.startLocationServices()
        }
        
    
    }
}

#Preview {
    MapView()
}
