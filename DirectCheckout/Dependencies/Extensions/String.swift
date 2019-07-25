//
//  String.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 23/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

extension String {
    
    func encrypt(key: String) throws -> String {
        return Crypto().sha256(source: self, key: key)
    }
    
    func base64() throws -> String {
        return try self.data(using: .utf8).orThrow().base64EncodedString()
    }
    
    func base64Decoded() throws -> String {
        let source = self.replacingOccurrences(of: "\r\n", with: "")
        let decodedData = try Data(base64Encoded: source).orThrow()
        return try String(data: decodedData, encoding: .utf8).orThrow()
    }
    
    func regex() -> NSRegularExpression {
        return try! NSRegularExpression(pattern: self, options: [])
    }
    
}
