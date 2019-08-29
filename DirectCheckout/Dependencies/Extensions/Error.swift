//
//  Error.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 28/08/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

extension Error {
    
    func makeError() -> DirectCheckoutError {
        return self as? DirectCheckoutError ?? DirectCheckoutError.underlying(self)
    }
    
}
