//
//  APIJsonStrategy.swift
//  Core
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

struct APIJsonStrategy: IAPIStrategy {
    
    func execute<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            if let error = error {
                DispatchQueue.main.async { completion(.failure(APIError.underlying(error: error))) }
            } else {
                let object: T = try T.decode(data: data!)
                let result: Result<T, Error> = Result.success(object)
                DispatchQueue.main.async { completion(result) }
            }
            
        } catch let error {
            let apiError = APIError.underlying(error: error)
            let result: Result<T, Error> = .failure(apiError)
            DispatchQueue.main.async { completion(result) }
        }
        
    }
    
}
