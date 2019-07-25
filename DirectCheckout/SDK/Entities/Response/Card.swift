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
    
    public init(cardNumber: String, holderName: String, securityCode: String, expirationMonth: String, expirationYear: String) {
        self.cardNumber = cardNumber
        self.holderName = holderName
        self.securityCode = securityCode
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
    }
    
    func encrypt(key: String) throws -> String {
        return try jsonString().encrypt(key: key).base64()
    }
    
}
