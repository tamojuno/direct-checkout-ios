//
//  Optional.swift
//  Extensions
//
//  Created by Diego Trevisan Lara on 19/11/18.
//  Copyright © 2018 Juno. All rights reserved.
//

public enum OptionalError: Error {
    case `nil`
}

public extension Optional {
    
    func orThrow() throws -> Wrapped {
        guard let value = self else { throw OptionalError.nil }
        return value
    }
    
}
