//
//  Card.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

public class Card: NSObject, Codable {
    
    let cardNumber: String
    let holderName: String
    let securityCode: String
    let expirationMonth: String
    let expirationYear: String
    
    @objc public init(cardNumber: String, holderName: String, securityCode: String, expirationMonth: String, expirationYear: String) {
        self.cardNumber = cardNumber.onlyNumbers
        self.holderName = holderName
        self.securityCode = securityCode.onlyNumbers
        self.expirationMonth = expirationMonth.onlyNumbers
        self.expirationYear = expirationYear.onlyNumbers
    }
    
    func encrypt(key: String) throws -> String {
        let publicKey = try CryptorRSA.createPublicKey(withPEM: key)
        let plainText = try CryptorRSA.createPlaintext(with: data())
        let encrypted = try plainText.encrypted(with: publicKey)
        
        return encrypted!.base64String.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
    }
    
}

// MARK: - Aux functions

public extension Card {
    
    func getType() -> CardType? {
        return CardUtils.getCardType(cardNumber)
    }
    
    @objc func validateNumber() -> Bool {
        return CardUtils.validateNumber(cardNumber)
    }
    
    @objc func validateCVC() -> Bool {
        return CardUtils.validateCVC(securityCode, cardNumber)
    }
    
    @objc func validateExpireDate() -> Bool {
        return CardUtils.validateExpireDate(expirationMonth, expirationYear)
    }
    
    func validate() throws -> Bool {
        guard !holderName.isEmpty else {
            throw CardError.emptyHolderName
        }
        
        guard validateNumber() else {
            throw CardError.invalidCardNumber
        }
        
        guard validateCVC() else {
            throw CardError.invalidSecurityCode
        }
        
        guard validateExpireDate() else {
            throw CardError.invalidExpireDate
        }
        
        return true
    }
    
}

// MARK: - Errors

public enum CardError: LocalizedError {
    case emptyHolderName
    case invalidCardNumber
    case invalidSecurityCode
    case invalidExpireDate
    
    public var errorDescription: String? {
        switch self {
        case .emptyHolderName:
            return "Nome do titular inválido."
            
        case .invalidCardNumber:
            return "Número do cartão inválido."
            
        case .invalidSecurityCode:
            return "Código de segurança inválido."
            
        case .invalidExpireDate:
            return "Data de expiração inválida."
        }
    }
}

// MARK: - Objective-C Support

public extension Card {
    
    @available(swift, obsoleted: 0.1)
    @objc func validate(success: (Card) -> Void, failure: (Error) -> Void) {
        do {
            _ = try validate()
            success(self)
        } catch {
            failure(error)
        }
    }
    
}
