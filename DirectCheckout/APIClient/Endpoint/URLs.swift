//
//  APIEndpointPath.swift
//  Juno
//
//  Created by Diego Trevisan Lara on 19/01/18.
//  Copyright © 2018 Juno. All rights reserved.
//

// MARK: - Enums

public struct APIEndpointUrl {
    let base: APIBaseUrl
    let path: EndpointPath
    
    public init(base: APIBaseUrl = .current, path: EndpointPath) {
        self.base = base
        self.path = path
    }
    
    var url: String {
        return "\(base.rawValue)\(path.value)"
    }
}

// MARK: - Base URL

public enum APIBaseUrl: String {
    case local =        "http://10.20.2.52:8095/manager-web"
    case production =   "https://boletobancario.com/boletofacil/integration/api/v1"
    case sandbox =      "https://sandbox.boletobancario.com/boletofacil"
    case sandboxJuno =  "https://sandbox.juno.com.br"
    case viaCep =       "https://viacep.com.br"
}

public extension APIBaseUrl {
    static var current: APIBaseUrl {
        #if DEBUG
            return .sandbox
        #else
            return .sandbox
        #endif
    }
}

// MARK: - Endpoint Path

public protocol EndpointPath {
    var value: String { get }
}
