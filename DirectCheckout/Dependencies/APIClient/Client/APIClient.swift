//
//  APIClient.swift
//  Core
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

struct APIClient: IAPIClient {
    
    let strategy: IAPIStrategy
    
    func execute<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, DirectCheckoutError>) -> Void) {
        
        let request = endpoint.build()
        
        session.dataTask(with: request) { data, response, error in
            self.strategy.execute(data: data, response: response, error: error, completion: completion)
        }.resume()
        
    }
}
