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
        
        let apiClient = APIClient(strategy: APIJunoStrategy())
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
                    } catch {
                        completion(.failure(error.makeError()))
                    }
                    
                })
                
            } catch {
                completion(.failure(error.makeError()))
            }
            
        }
    }
    
    // MARK: - Aux functions
    
    static func getCardType(_ cardNumber: String) -> CardType? {
        return CardUtils.getCardType(cardNumber)
    }
    
    public static func isValidCardNumber(_ cardNumber: String) -> Bool {
        return CardUtils.validateNumber(cardNumber)
    }
    
    public static func isValidSecurityCode(_ cardNumber: String, _ securityCode: String) -> Bool {
        return CardUtils.validateCVC(cardNumber, securityCode)
    }
    
    public static func isValidExpireDate(month: String, year: String) -> Bool {
        return CardUtils.validateExpireDate(month, year)
    }
    
}
