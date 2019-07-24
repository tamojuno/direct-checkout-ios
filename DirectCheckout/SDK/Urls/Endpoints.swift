//
//  Endpoints.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

enum Endpoint: String, EndpointPath {
    
    case getEncryptionKey           = "/get-public-encryption-key.json"
    case getCreditCardHash          = "/get-credit-card-hash.json"
    
    var value: String {
        return rawValue
    }
    
}
