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
    
    var data: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    var json: [String: Any]? {
        do {
            let data = try self.data.orThrow()
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch let error {
            return nil
        }
    }
    
    var jsonString: String {
        if let data = self.data, let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        }
        
        return ""
    }
    
}

extension Array where Element: Codable {
    
    var json: [[String: Any]]? {
        return self.compactMap({ $0.json })
    }
    
}
