//
//  MapView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

import SwiftUI
import MapKit
import ShimmeringUiView

struct MapView: View {
    @State private var locationManager = LocationManager()
    @StateObject var viewModel = ServiceViewModel()
    @State var selectedService: Service?
    @Binding var selectedFilter: String
    @State var showFilters: Bool
    @State var searchText: String = ""
    @State var isUserLocationOn = false
    
    
    @State var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -8.06317, longitude: -34.87114),
        span: MKCoordinateSpan(latitudeDelta: 0.1000, longitudeDelta: 0.1000)))
    
    var body: some View {
            VStack{
                
                if(locationManager.isAuthorized){
                        Map(position: $region){
                            UserAnnotation()
                            ForEach(0 ..< viewModel.filteredServices.count, id: \.self) { index in
                                let service = viewModel.filteredServices[index]
                                Annotation(service.name, coordinate: CLLocationCoordinate2D(latitude: service.coordinate.latitude, longitude: service.coordinate.longitude)){
                                    Button(action: {
                                        selectedService = service
                                    }) {
                                        Image("pin")
                                            .resizable()
                                            .foregroundColor(.verde)
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        
                        .sheet(item: $selectedService) { service in
                            SheetDetailView(service: service)
                                .presentationDragIndicator(.visible)
                        }
                        .mapControls {
                            MapUserLocationButton()
                        }
                    .safeAreaInset(edge: .top){
                        if showFilters {
                            VStack{
                                CategoryFilter(selectedFilter: $selectedFilter)
                            }.padding()
                        }
                    }
                    
                }
            }.onAppear {
                addNavBarBackground()
                locationManager.startLocationServices()
            Task {
                await viewModel.loadServices()
                viewModel.filterServices(by: selectedFilter, searchText: searchText)
            }
                

        }
        .onChange(of: selectedFilter){
            viewModel.filterServices(by: selectedFilter, searchText: searchText)
            selectedService = nil
        }
        .onChange(of: locationManager.userLocation){
            if !isUserLocationOn {
                region = MapCameraPosition.region(MKCoordinateRegion(
                    center: locationManager.userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: -8.06317, longitude: -34.87114),
                    span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)))
                isUserLocationOn = true
            }
            
        }
        .toolbarBackground(.bege, for: .tabBar)
        .toolbarBackground(.bege, for: .navigationBar)
        
    }
}




