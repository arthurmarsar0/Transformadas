//
//  ServiceModel.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 27/10/24.
//

import CloudKit

var database = CKContainer(identifier: "iCloud.br.ufpe.cin.pvom.Transformadas").publicCloudDatabase

class ServiceModel {
    
    static func recordToService(record: CKRecord) throws -> Service {
        guard
            let name = record["name"] as? String,
            let categories = record["categories"] as? [String],
            let email = record["email"] as? String,
            let telephone = record["telephone"] as? String,
            let description = record["description"] as? String,
            let address = record["address"] as? [String],
            let coordinate = record["coordinate"] as? [Double] else {
                throw ServiceError.invalidRecord
        }
        
        let service = Service(
            ID: record.recordID.recordName,
            name: name,
            categories: categories.map({Category.nameToCategory(name: $0)}),
            email: email,
            telephone: telephone,
            description: description,
            address: Address.listToAddress(list: address),
            coordinate: CLLocationCoordinate2D.listToCoordinate(list: coordinate)
            )
        
        return service
    }
    
    static func addService(service: Service) async throws {
        
        var serviceRecord = CKRecord(recordType: "Service")
        
        serviceRecord["name"] = service.name
        serviceRecord["categories"] = service.categories.map({$0.name})
        serviceRecord["email"] = service.email
        serviceRecord["telephone"] = service.telephone
        serviceRecord["description"] = service.description
        serviceRecord["address"] = service.address.addressToList()
        serviceRecord["coordinates"] = service.coordinate.coordinateToList()
        
        let addedRecord = try await database.save(serviceRecord)
        
    }
    
    static func getServices() async throws -> [Service] {
        
        let query = CKQuery(recordType: "Service", predicate: NSPredicate(value: true))
        
        let packedRecords = try await database.records(matching: query)
        
        let records = try packedRecords.matchResults.map({try $0.1.get()})
        
        let services = try records.map({try recordToService(record: $0)})
        
        return services
        
    }
    
    static func deleteService(service: Service) async throws {
        
        guard let serviceID = service.ID else {
            throw ServiceError.invalidID
        }
        
        var recordID = CKRecord.ID(recordName: serviceID)
        
        let record = try await database.deleteRecord(withID: recordID)
        
    }
    
}
