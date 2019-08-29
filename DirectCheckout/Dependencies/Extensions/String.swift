//
//  String.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 23/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

extension String {
    
    func regex() -> NSRegularExpression {
        return try! NSRegularExpression(pattern: self, options: [])
    }
    
    var onlyNumbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
}
