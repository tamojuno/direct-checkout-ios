//
//  Crypto.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 22/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

import CommonCrypto

//const val CRYPTO_METHOD = "RSA"
//const val MD_NAME = "SHA-256"
//const val MG_NAME = "MGF1"
//const val CRYPTO_TRANSFORM = "RSA/ECB/OAEPPadding"

class Crypto {
    
    func sha256(source: String, key: String) -> String {
        
        let input = source + key
        
        if let strData = input.data(using: String.Encoding.utf8) {
            var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
            strData.withUnsafeBytes {
                _ = CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
            }
            
            var sha256String = ""
            for byte in digest {
                sha256String += String(format:"%02x", UInt8(byte))
            }
            
            return sha256String
        }
        
        return ""
    }
    
}
