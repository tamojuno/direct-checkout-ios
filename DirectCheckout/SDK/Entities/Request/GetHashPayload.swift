//
//  GetHashPayload.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 22/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

struct GetHashPayload: Codable {
    let publicToken: String
    let encryptedData: String
}
