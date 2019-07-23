//
//  APIResult.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 12/01/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

struct APIResult<T: Decodable>: Decodable {
    var success: Bool
    var data: T?
    var errorMessage: String?
    
    func makeResult() throws -> Result<T, Error> {
        if success, let data = data ?? VoidResponse() as? T {
            return .success(data)
        }
        
        guard let errorMessage = errorMessage else {
            return .failure(APIError.emptyData)
        }
        
        let messageData = try errorMessage.data(using: String.Encoding.unicode).orThrow()
        let attrString = try NSAttributedString(data: messageData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return .failure(APIError.remote(message: attrString.string))
    }
    
}

struct VoidResponse: Decodable {
    
}
