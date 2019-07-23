//
//  APIHtmlStrategy.swift
//  Core
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Juno. All rights reserved.
//

struct APIHtmlStrategy: IAPIStrategy {
    
    func execute<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            if let error = error {
                DispatchQueue.main.async { completion(.failure(APIError.underlying(error: error))) }
            } else {
                let apiResult = try APIResult<T>.decode(data: data!)
                let result = try apiResult.makeResult()
                DispatchQueue.main.async { completion(result) }
            }
        } catch let error {
            // Assumes session has been lost, clears cookies and sends notification to route to login view
            if response?.url?.absoluteString.contains("/login.html") == true {
                #warning("Cuspir erro")
                HTTPCookieStorage.shared.cookies?.forEach({ HTTPCookieStorage.shared.deleteCookie($0) })
            } else {
                let apiError = APIError.underlying(error: error)
                let result: Result<T, Error> = .failure(apiError)
                DispatchQueue.main.async { completion(result) }
            }
        }
        
    }
    
}
