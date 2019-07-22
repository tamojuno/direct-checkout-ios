//
//  DirectCheckoutGateway.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

protocol DirectCheckoutGateway {
    func getPublicEncryptionKey(completion: @escaping (_ result: Result<String, Error>) -> Void)
    func getCreditCardHash(completion: @escaping (_ result: Result<String, Error>) -> Void)
}

struct APIDirectCheckoutGateway: DirectCheckoutGateway {
    
    let apiClient: APIClient
    
    func getPublicEncryptionKey(completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = APIEndpointUrl(path: Endpoint.getPublicEncryptionKey)
        let apiEndpoint = APIEndpoint(url: url, method: .get, encoding: .urlEncoded(nil))
        
        apiClient.execute(endpoint: apiEndpoint) { (result: Result<String, Error>) in
            
        }
        
    }
    
    func getCreditCardHash(completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = APIEndpointUrl(path: Endpoint.getCreditCardHash)
        let apiEndpoint = APIEndpoint(url: url, method: .get, encoding: .urlEncoded(nil))
        
        apiClient.execute(endpoint: apiEndpoint) { (result: Result<String, Error>) in
            
        }
        
    }
    
}
