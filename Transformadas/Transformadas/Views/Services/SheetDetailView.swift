//
//  SheetDetailView.swift
//  Transformadas
//
//  Created by Alice Barbosa on 31/10/24.
//

import SwiftUI
import MapKit

var region: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -8.06317, longitude: -34.87114),
                                                                            span: MKCoordinateSpan(latitudeDelta: 0.1000, longitudeDelta: 0.1000)))


struct SheetDetailView: View {
    
    @State var selectedFilter: String = "Todos"
    
    var service: Service
    
    var body: some View {
        ZStack(alignment: .top){
            Color.bege.ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading, spacing: 16){
                    
                    VStack(alignment: .leading){
                        HStack {
                            ForEach(service.categories , id: \.self) { category in
                                if !category.symbol.isEmpty{
                                    Image(systemName: category.symbol)
                                        .foregroundStyle(category.color)
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        
                        Text(service.name)
                            .font(.system(size: 32, weight: .medium))
                            .foregroundStyle(.rosa)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Endereço e Contato")
                            .font(.system(size: 18, weight: .bold))
                        HStack{
                            Image(systemName: "phone.fill")
                            Text(service.telephone)
                            
                        }
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text(service.address.street + ", " + service.address.neighborhood + ", " + service.address.city)
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("Sobre")
                            .font(.system(size: 18, weight: .bold))
                        Text(service.description)
                    }
                    
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 16)
//                            .frame(height: 180)
//                            .foregroundStyle(.black)
//                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 2))
//
//                        
//                        Map(initialPosition: region){
//                            Annotation(service.name, coordinate: service.coordinate){
//                                Image("pin")
//                                    .resizable()
//                                    .foregroundColor(.verde)
//                                
//                            }
//                        }
//                        .frame(height: 180)
//                        .clipShape(RoundedRectangle(cornerRadius: 16))
//                        
//                    }
//                    .onTapGesture {
//                        openInWaze()
//                    }

                }
                .padding()
                Spacer()
                Button {
                    openInWaze()
                } label: {
                    HStack{
                        Image(systemName: "paperplane.circle.fill")
                            .font(.system(size: 20, weight: .semibold))
                        Text("Traçar rota")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .foregroundStyle(.verde)
                    
                }
            }
        }.onAppear {
            region = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: service.coordinate.latitude, longitude: service.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)))
        }
        
    }
    private func openInWaze() {
        let urlString = "waze://?ll=\(service.coordinate.latitude),\(service.coordinate.longitude)&navigate=yes"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Caso Waze não esteja instalado
            let fallbackURL = "https://www.waze.com/ul?ll=\(service.coordinate.latitude),\(service.coordinate.longitude)&navigate=yes"
            if let fallbackURL = URL(string: fallbackURL) {
                UIApplication.shared.open(fallbackURL)
            }
        }
    }
    
}

