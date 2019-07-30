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
    
    // MARK: - Get hash
    
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
                    } catch let error as DirectCheckoutError {
                        completion(.failure(error))
                    } catch {
                        completion(.failure(DirectCheckoutError.underlying(error)))
                    }
                    
                })
                
            } catch let error as DirectCheckoutError {
                completion(.failure(error))
            } catch {
                completion(.failure(DirectCheckoutError.underlying(error)))
            }
            
        }
    }
    
    // MARK: - Aux functions
    
    public static func isValidCardNumber(_ cardNumber: String) -> Bool {
        return CardUtils.validateNumber(cardNumber)
    }
    
    static func getCardType(_ cardNumber: String) -> String? {
        return CardUtils.getCardType(cardNumber)?.name
    }
    
    public static func isValidSecurityCode(_ cardNumber: String, _ securityCode: String) -> Bool {
        return CardUtils.validateCVC(cardNumber, securityCode)
    }
    
    public static func isValidExpireDate(month: String, year: String) -> Bool {
        return CardUtils.validateExpireDate(month, year)
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
    
}
