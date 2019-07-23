//
//  GetKeyPayload.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 22/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

struct GetKeyPayload: Codable {
    let publicToken: String
    let version: String
}
