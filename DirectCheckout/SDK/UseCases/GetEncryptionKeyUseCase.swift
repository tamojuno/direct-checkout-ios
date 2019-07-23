//
//  GetEncryptionKeyUseCase.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

protocol IGetEncryptionKeyUseCase {
    func get(publicToken: String, version: String, completion: @escaping (_ result: Result<String, Error>) -> Void)
}

struct GetEncryptionKeyUseCase: IGetEncryptionKeyUseCase {

    let gateway: DirectCheckoutGateway
    
    func get(publicToken: String, version: String, completion: @escaping (Result<String, Error>) -> Void) {
        let payload = GetKeyPayload(publicToken: publicToken, version: version)
        gateway.getEncryptionKey(payload: payload, completion: completion)
    }

}
