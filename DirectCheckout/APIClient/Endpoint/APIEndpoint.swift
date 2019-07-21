//
//  APIEndpoint.swift
//  Juno
//
//  Created by Diego Trevisan Lara on 12/01/18.
//  Copyright © 2018 Juno. All rights reserved.
//

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum ParameterEncoding {
    case urlEncoded(Codable?)
    case queryString(Codable?)
    case json(Codable?)
}

open class APIEndpoint {
    
    let url: APIEndpointUrl
    let method: HTTPMethod
    let encoding: ParameterEncoding
    
    public init(url: APIEndpointUrl, method: HTTPMethod = .get, encoding: ParameterEncoding = .urlEncoded(nil)) {
        self.url = url
        self.method = method
        self.encoding = encoding
    }
    
    open func build() -> URLRequest {
        let url = URL(string: self.url.url)!
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        request.httpMethod = method.rawValue
        
        switch encoding {
            
        case .urlEncoded(let parameter):
            request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
            request.httpBody = parameter?.json?.queryString.data(using: .utf8)
            
        case .json(let parameter):
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            request.httpBody = parameter?.data
            
        case .queryString(let parameter):
            if let queryString = parameter?.json?.queryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                request.url = URL(string: "\(self.url.url)?\(queryString)")!
            }
        }
        
        return request
    }
    
}
