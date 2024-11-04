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
    @State var services: [Service] = []
    @State var isSheetPresented: Bool = false
    @StateObject var viewModel = ServiceViewModel()
    @State var selectedService: Service?
    @Binding var selectedFilter: String
    @State var showFilters: Bool
    
    
    @State var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -8.05592, longitude: -34.95108),
        span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)))
    
    var body: some View {
        ZStack {
            Color.bege.ignoresSafeArea()
            if(locationManager.isAuthorized){
                
                Map(position: $region){
                    UserAnnotation()
                    ForEach(0 ..< viewModel.filteredServices.count, id: \.self) { index in
                        let service = viewModel.filteredServices[index]
                        Annotation(service.name, coordinate: CLLocationCoordinate2D(latitude: service.coordinate.latitude, longitude: service.coordinate.longitude)){
                                Button(action: {
                                    selectedService = service
                                    isSheetPresented.toggle()
                                }) {
                                    Image("pin")
                                        .resizable()
                                        .foregroundColor(.verde)
                                }
                                .sheet(isPresented: $isSheetPresented) {
                                    if let service = selectedService {
                                        SheetDetailView(service: service)
                                    }
                                }
                        }
                        }
                
                }.mapControls {
                    MapUserLocationButton()
                }
                .safeAreaInset(edge: .top){
                    if showFilters {
                        
                        CategoryFilter(selectedFilter: $selectedFilter)
                    }
                }
                
            }
        }.onAppear {
            Task {
                await viewModel.loadServices()
                viewModel.filterServices(by: selectedFilter)
            }
            
            region = MapCameraPosition.region(MKCoordinateRegion(
                center: locationManager.userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: -8.05592, longitude: -34.95108),
                span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)))
        }
        .onChange(of: selectedFilter){
            viewModel.filterServices(by: selectedFilter)
        }
        
        
    
    }
}




