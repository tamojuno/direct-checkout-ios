//
//  Errors.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

#warning("Rever textos")

public enum DirectCheckoutError: LocalizedError {
    case notInitilizated
    
    public var errorDescription: String? {
        switch self {
        case .notInitilizated:
            return "SDK não inicializado."
        }
    }
}
