//
//  APIResult.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 12/01/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

import Foundation

struct APIResult<T: Decodable>: Decodable {
    var success: Bool
    var data: T?
    var errorMessage: String?
    
    func makeResult() throws -> Result<T, DirectCheckoutError> {
        if success, let data = data {
            return .success(data)
        }
        
        guard let errorMessage = errorMessage else {
            return .failure(DirectCheckoutError.unknown("A requisição falhou mas o servidor não retornou uma mensagem de erro."))
        }
        
        return .failure(DirectCheckoutError.remote(errorMessage))
    }
    
}
