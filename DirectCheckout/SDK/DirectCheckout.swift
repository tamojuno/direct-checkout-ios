//
//  DirectCheckout.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

public class DirectCheckout {
    
    private static var publicToken: String?
    
    public static func initialize(publicToken: String, environment: APIEnvionment = .production) {
        self.publicToken = publicToken
        APIEnvionment.current = environment
    }
    
    public static func getCardHash(_ card: Card, completion: @escaping (Result<String, DirectCheckoutError>) -> Void) {
        
        guard let publicToken = publicToken else {
            completion(.failure(DirectCheckoutError.notInitilizated))
            return
        }
        
        let apiClient = APIClient(strategy: APIHtmlStrategy())
        let gateway = APIDirectCheckoutGateway(apiClient: apiClient)
        
        let getEncryptionKeyUseCase = GetEncryptionKeyUseCase(gateway: gateway)
        let getCreditCardHashUseCase = GetCreditCardHashUseCase(gateway: gateway)
        
        getEncryptionKeyUseCase.get(publicToken: publicToken, version: "0.0.2") { result in
            
            do {
                let encryptionKey = try result.get()
                let encryptedData = try card.encrypt(key: encryptionKey)
                
                getCreditCardHashUseCase.get(publicToken: publicToken, encryptedData: encryptedData, completion: { result in
                    
                    do {
                        let cardHash = try result.get()
                        completion(.success(cardHash))
                        
                    } catch let error {
                        print(error)
                    }
                    
                })
                
            } catch let error {
                print(result)
            }
            
        }
    }
    
    public static func isValidCardNumber(_ cardNumber: String) -> Bool {
//        let cardNo = cardNumber.replacingOccurrences(of: " ", with: "")
//        let type = getCardType(cardNumber)
//        return type != null && type.cardLength == cardNo.length && validateNum(cardNo)
        return false
    }
    
    public static func isValidSecurityCode(_ cardNumber: String, _ securityCode: String) -> Bool {
        let cardLabel = CardLabel.all().first(where: { $0.matches(cardNumber: cardNumber) })
        return cardLabel?.cvcLength == securityCode.count
    }
    
    public static func isValidExpireDate(month: String, year: String) -> Bool {
        guard let expirationMonth = Int(month), let expirationYear = Int(year), expirationMonth > 0, expirationYear > 0 else {
            return false
        }
        
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        
        return expirationYear >= currentYear ? (expirationYear == currentYear ? expirationMonth > currentMonth : true) : false
    }
    
    public static func isValidCardData(_ card: Card) throws -> Bool {
//        if(card.holderName.isEmpty()){
//            throw DirectCheckoutException("Invalid holder name")
//        }
//        if(!CardUtils.validateNumber(card.cardNumber)){
//            throw DirectCheckoutException("Invalid card number")
//        }
//
//        if(!CardUtils.validateCVC(card.cardNumber, card.securityCode)){
//            throw DirectCheckoutException("Invalid security code")
//        }
//
//        if(!CardUtils.validateExpireDate(card.expirationMonth, card.expirationYear)){
//            throw DirectCheckoutException("Invalid expire date")
//        }
        
        return true
    }
    
    public static func getCardType(_ cardNumber: String) -> String? {
        let cardLabel = CardLabel.all().first(where: { $0.matches(cardNumber: cardNumber) })
        return cardLabel?.name
    }
    
}
