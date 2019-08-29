//
//  Codability.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 18/01/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

extension Decodable {
    
    typealias T = Self
    
    static func decode(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
            
        } catch let error {
            throw error
        }
    }
    
}

extension Encodable {
    
    func data() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
    
    func json() throws -> [String: Any] {
        let json = try JSONSerialization.jsonObject(with: data(), options: [])
        return json as! [String: Any]
    }
    
}
