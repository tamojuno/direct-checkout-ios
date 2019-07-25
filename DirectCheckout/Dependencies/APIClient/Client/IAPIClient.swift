//
//  IAPIClient.swift
//  Core
//
//  Created by Diego Trevisan Lara on 07/11/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

protocol IAPIClient {
    func execute<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, DirectCheckoutError>) -> Void)
}

extension IAPIClient {
    
    var session: URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 15.0
        return URLSession(configuration: sessionConfig)
    }
    
}
