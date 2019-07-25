//
//  Errors.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

public enum DirectCheckoutError: LocalizedError {
    case notInitilizated
    case underlying(Error)
    case remote(String)
    case unknown(String)
    
    public var errorDescription: String? {
        switch self {
        case .underlying(let error):
            return error.localizedDescription
            
        case .notInitilizated:
            return "SDK não inicializado."
            
        case .remote(let message):
            return message
        
        case .unknown(let message):
            return message
        }
    }
}

public enum CardValidationError: LocalizedError {
    case invalidHolderName
    case invalidCardNumber
    case invalidSecurityCode
    case invalidExpireDate
    
    public var errorDescription: String? {
        switch self {
        case .invalidHolderName:
            return ""
            
        case .invalidCardNumber:
            return ""
            
        case .invalidSecurityCode:
            return ""
            
        case .invalidExpireDate:
            return ""
        }
    }
}
