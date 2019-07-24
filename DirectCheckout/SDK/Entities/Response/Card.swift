//
//  Card.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

public struct Card: Codable {
    
    let cardNumber: String
    let holderName: String
    let securityCode: String
    let expirationMonth: String
    let expirationYear: String
    
    func encrypt(key: String) throws -> String {
        return try jsonString().encrypt(key: key).base64()
    }
    
}
