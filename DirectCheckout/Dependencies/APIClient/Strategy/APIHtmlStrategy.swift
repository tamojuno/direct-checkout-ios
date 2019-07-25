//
//  APIHtmlStrategy.swift
//  Core
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Juno. All rights reserved.
//

struct APIHtmlStrategy: IAPIStrategy {
    
    func execute<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, DirectCheckoutError>) -> Void) {
        
        do {
            if let error = error {
                DispatchQueue.main.async { completion(.failure(.underlying(error))) }
            } else {
                let apiResult = try APIResult<T>.decode(data: data!)
                let result = try apiResult.makeResult()
                DispatchQueue.main.async { completion(result) }
            }
        } catch let error {
            // Assumes session has been lost, clears cookies and sends notification to route to login view
            if response?.url?.absoluteString.contains("/login.html") == true {
                let result: Result<T, DirectCheckoutError> = .failure(.remote("O servidor redirecionou para uma página incorreta."))
                DispatchQueue.main.async { completion(result) }
            } else {
                let result: Result<T, DirectCheckoutError> = .failure(.underlying(error))
                DispatchQueue.main.async { completion(result) }
            }
        }
        
    }
    
}
