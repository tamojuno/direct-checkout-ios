//
//  DirectCheckoutGateway.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

protocol DirectCheckoutGateway {
    func getEncryptionKey(payload: GetKeyPayload, completion: @escaping (_ result: Result<String, DirectCheckoutError>) -> Void)
    func getCreditCardHash(payload: GetHashPayload, completion: @escaping (_ result: Result<String, DirectCheckoutError>) -> Void)
}

struct APIDirectCheckoutGateway: DirectCheckoutGateway {
    
    let apiClient: APIClient
    
    func getEncryptionKey(payload: GetKeyPayload, completion: @escaping (_ result: Result<String, DirectCheckoutError>) -> Void) {
        let url = APIEndpointUrl(path: Endpoint.getEncryptionKey)
        let apiEndpoint = APIEndpoint(url: url, method: .post, encoding: .urlEncoded(payload))
        apiClient.execute(endpoint: apiEndpoint, completion: completion)
    }
    
    func getCreditCardHash(payload: GetHashPayload, completion: @escaping (_ result: Result<String, DirectCheckoutError>) -> Void) {
        let url = APIEndpointUrl(path: Endpoint.getCreditCardHash)
        let apiEndpoint = APIEndpoint(url: url, method: .post, encoding: .urlEncoded(payload))
        apiClient.execute(endpoint: apiEndpoint, completion: completion)
    }
    
}
