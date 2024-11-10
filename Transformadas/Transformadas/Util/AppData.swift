//
//  AppData.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 05/11/24.
//

import Foundation

class AppData: ObservableObject {
    @Published var primeiraAbertura: Bool{
        didSet {
                UserDefaults.standard.set(primeiraAbertura, forKey: "primeiraAbertura")
                }
    }
    
    @Published var appleID: String {
        didSet {
            UserDefaults.standard.set(appleID, forKey: "appleID")
        }
    }
    
    init() {
            self.primeiraAbertura = UserDefaults.standard.bool(forKey: "primeiraAbertura")
            self.appleID = UserDefaults.standard.string(forKey: "appleID") ?? ""
        }

}
