//
//  MapView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 29/10/24.
//

//import SwiftUI
//import MapKit
//
//struct MapView: View {
//    @State private var locationManager = LocationManager()
//    @State var services: [Service] = []
//    @State var isSheetPresented: Bool = false
//    var selectedFilter: String
//    var body: some View {
//        ZStack {
//            if(locationManager.isAuthorized){
//                Map(){
//                    UserAnnotation()
//                    ForEach(0 ..< services.count, id: \.self) { index in
//                        let service = services[index]
//                        Annotation(service.name, coordinate: CLLocationCoordinate2D(latitude: service.coordinate.latitude, longitude: service.coordinate.longitude)){
//                                Button(action: {
//                                    isSheetPresented.toggle()
//                                }) {
//                                    Image(systemName: "mappin.and.ellipse")
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                        .foregroundColor(.verde)
//                                }
//                                .sheet(isPresented: $isSheetPresented){
//                                    SheetDetailView(service: service)
//                                }
//                            }
//                        }
//                
//                }.mapControls {
//                    MapUserLocationButton()
//                }
//            }
//        }.onAppear {
//            locationManager.startLocationServices()
//            Task{
//                do{
//                    services = try await ServiceModel.getServices()
//                }catch{
//                    print("Erro ao carregar serviços: \(error)")
//                }
//            }
//            
//        }
//        
//        
//        
//    
//    }
//}

import SwiftUI
import MapKit

struct MapView: View {
    @State private var locationManager = LocationManager()
    @State var services: [Service] = []
    @State var isSheetPresented: Bool = false
    var selectedFilter: String
    @StateObject var viewModel = ServiceViewModel()
    var body: some View {
        ZStack {
            if(locationManager.isAuthorized){
                Map(){
                    UserAnnotation()
                    ForEach(0 ..< viewModel.filteredServices.count, id: \.self) { index in
                        let service = viewModel.filteredServices[index]
                        Annotation(service.name, coordinate: CLLocationCoordinate2D(latitude: service.coordinate.latitude, longitude: service.coordinate.longitude)){
                                Button(action: {
                                    isSheetPresented.toggle()
                                }) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.verde)
                                }
                                .sheet(isPresented: $isSheetPresented){
                                    SheetDetailView(service: service)
                                }
                            }
                        }
                
                }.mapControls {
                    MapUserLocationButton()
                }
            }
        }.onAppear {
            Task {
                await viewModel.loadServices()
                viewModel.filterServices(by: selectedFilter)
            }
        }
        .onChange(of: selectedFilter){
            viewModel.filterServices(by: selectedFilter)
        }
        
        
    
    }
}



//#Preview {
//    MapView()
//}


