//
//  Dictionary.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 25/06/18.
//  Copyright © 2018 Juno Pagamentos. All rights reserved.
//

extension Dictionary {
    
    var queryString: String {
        var output: String = ""
        for (key, value) in self {
            output = "\(output)\(key)=\(value)&"
        }
        
        output = String(output.dropLast())
        return output
    }
    
}
