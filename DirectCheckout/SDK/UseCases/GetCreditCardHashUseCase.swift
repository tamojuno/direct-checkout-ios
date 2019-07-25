//
//  GetCreditCardHashUseCase.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 23/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

protocol IGetCreditCardHashUseCase {
    func get(publicToken: String, encryptedData: String, completion: @escaping (_ result: Result<String, DirectCheckoutError>) -> Void)
}

struct GetCreditCardHashUseCase: IGetCreditCardHashUseCase {

    let gateway: DirectCheckoutGateway
    
    func get(publicToken: String, encryptedData: String, completion: @escaping (Result<String, DirectCheckoutError>) -> Void) {
        let payload = GetHashPayload(publicToken: publicToken, encryptedData: encryptedData)
        gateway.getCreditCardHash(payload: payload, completion: completion)
    }

}
