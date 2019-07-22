//
//  APIError.swift
//  Core
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

#warning("Rever erros")

enum APIError: LocalizedError {
    case remote(message: String)
    case emptyData
    case underlying(error: Error)
    case unknown(request: URLRequest?, response: URLResponse?)

    var errorDescription: String? {
        switch self {
        case .remote(let message):
            return message
            
        case .emptyData:
            return "ERROR_EMPTY_DATA"
            
        case .underlying(let error):
            return error.localizedDescription
            
        case .unknown:
            return "ERROR_UNKNOWN_MESSAGE"
        }
    }
}
