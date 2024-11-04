//
//  ServiceTypes.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 27/10/24.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    
    func coordinateToList() -> [Double] {
        return [self.latitude, self.longitude]
    }
    
    static func listToCoordinate(list: [Double]) -> CLLocationCoordinate2D {
        let latitude = list[0]
        let longitude = list[1]
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}


