//
//  Card.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

//import CryptorRSA

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
        let publicKey = try CryptorRSA.createPublicKey(withPEM: key)
        let plainText = try CryptorRSA.createPlaintext(with: data())
        let encrypted = try plainText.encrypted(with: publicKey, algorithm: .sha256)
        
        return encrypted!.base64String.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
    }
    
}
