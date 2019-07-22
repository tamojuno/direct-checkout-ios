//
//  DirectCheckout.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

public class DirectCheckout {
    
    private static var token: String?
    
    public static func initialize(token: String, environment: APIEnvionment = .production) {
        self.token = token
        APIEnvionment.current = environment
    }
    
    public static func getCardHash(_ card: Card, completion: (Result<String, DirectCheckoutError>) -> Void) {
        
        guard let token = token else {
            completion(.failure(DirectCheckoutError.notInitilizated))
            return
        }
        
        print(token)
        
    }
    
}
