//
//  Dictionary.swift
//  Juno
//
//  Created by Diego Trevisan Lara on 25/06/18.
//  Copyright © 2018 Juno. All rights reserved.
//

extension Dictionary {
    
    public var queryString: String {
        var output: String = ""
        for (key, value) in self {
            output = "\(output)\(key)=\(value)&"
        }
        
        output = String(output.dropLast())
        return output
    }
    
}
