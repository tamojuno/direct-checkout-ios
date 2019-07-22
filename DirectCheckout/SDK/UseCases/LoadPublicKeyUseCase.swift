//
//  LoadPublicKeyUseCase.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

protocol ILoadPublicKeyUseCase {
    func load(completion: @escaping (_ result: Result<String, Error>) -> Void)
}

struct LoadPublicKeyUseCase: ILoadPublicKeyUseCase {

    //let gateway: <#Gateway#>
    
    func load(completion: @escaping (Result<String, Error>) -> Void) {
        
    }

}
