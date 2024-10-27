//
//  Error.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 27/10/24.
//

import Foundation

public enum ModelError: LocalizedError {
    case notFound
    case invalidField
    
    public var errorDescription: String? {
        switch self {
            case .notFound: return "Erro ao obter model. Não encontrado"
            case .invalidField: return "Erro ao obter atributo do Model. Objeto Inválido"
        }
    }
}

public enum ServiceError: LocalizedError {
    case invalidRecord
    case invalidID
    
    public var errorDescription: String? {
        switch self {
            case .invalidRecord: return "Erro ao converter Record para Service. Atributos Inválidos"
            case .invalidID: return "Erro ao obter ID da Service. Objeto Inválido"
        }
    }
}

