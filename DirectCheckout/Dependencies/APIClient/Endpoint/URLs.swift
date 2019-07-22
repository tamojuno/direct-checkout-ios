//
//  APIEndpointPath.swift
//  Juno
//
//  Created by Diego Trevisan Lara on 19/01/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

// MARK: - Enums

struct APIEndpointUrl {
    let base: APIEnvionment
    let path: EndpointPath
    
    init(base: APIEnvionment = .current, path: EndpointPath) {
        self.base = base
        self.path = path
    }
    
    var url: String {
        return "\(base.rawValue)\(path.value)"
    }
}

// MARK: - Environment

public enum APIEnvionment: String {
    case production =   "https://www.boletobancario.com/boletofacil/integration/api"
    case sandbox =      "https://sandbox.boletobancario.com/boletofacil/integration/api"
    
    static var current: APIEnvionment = .production
}

// MARK: - Endpoint Path

protocol EndpointPath {
    var value: String { get }
}
