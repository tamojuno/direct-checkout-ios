//
//  CardUtils.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 24/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

class CardUtils {
    
    static func getCardType(_ cardNumber: String) -> CardType? {
        return CardType.allCases.first(where: { $0.assets().matches(cardNumber: cardNumber.onlyNumbers) })
    }
    
    static func validateNumber(_ cardNumber: String) -> Bool {
        let clearCardNumber = cardNumber.onlyNumbers
        let cardType = getCardType(clearCardNumber)?.assets()
        return cardType?.cardLength == clearCardNumber.count && luhnCheck(clearCardNumber)
    }
    
    static func validateCVC(_ securityCode: String, _ cardNumber: String) -> Bool {
        let cardType = getCardType(cardNumber)?.assets()
        return cardType?.cvcLength == securityCode.count
    }
    
    static func validateExpireDate(_ month: String, _ year: String) -> Bool {
        guard let expirationMonth = Int(month), let expirationYear = Int(year), expirationMonth > 0, expirationYear > 0 else {
            return false
        }
        
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        
        return expirationYear >= currentYear ? (expirationYear == currentYear ? expirationMonth > currentMonth : true) : false
    }
    
    private static func luhnCheck(_ cardNumber: String) -> Bool {
        var sum = 0
        let reversedCharacters = cardNumber.reversed().map { String($0) }
        
        for (idx, element) in reversedCharacters.enumerated() {
            guard let digit = Int(element) else { return false }
            switch ((idx % 2 == 1), digit) {
            case (true, 9): sum += 9
            case (true, 0...8): sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        
        return sum % 10 == 0
    }
    
}
