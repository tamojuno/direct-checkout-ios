//
//  Card.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

import SwiftyRSA

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
//        let jsonString = try self.jsonString()
//        let encrypted = RSA.encryptString(jsonString, publicKey: key)
        
        let publicKey = try PublicKey(pemEncoded: key)
        let clear = try ClearMessage(string: self.jsonString(), using: .utf8)
        let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)

        return encrypted.base64String.addingPercentEncoding(withAllowedCharacters:.alphanumerics)!
//        return encrypted!.addingPercentEncoding(withAllowedCharacters:.alphanumerics)!
    }
    
}
