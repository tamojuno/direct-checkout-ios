//
//  CryptorRSAKey.swift
//  CryptorRSA
//
//  Created by Bill Abt on 1/18/17.
//
//  Copyright © 2017 IBM. All rights reserved.
//
// 	Licensed under the Apache License, Version 2.0 (the "License");
// 	you may not use this file except in compliance with the License.
// 	You may obtain a copy of the License at
//
// 	http://www.apache.org/licenses/LICENSE-2.0
//
// 	Unless required by applicable law or agreed to in writing, software
// 	distributed under the License is distributed on an "AS IS" BASIS,
// 	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// 	See the License for the specific language governing permissions and
// 	limitations under the License.
//

import CommonCrypto
import Foundation

@available(macOS 10.12, iOS 10.3, watchOS 3.3, tvOS 12.0, *)
extension CryptorRSA {
    
    public typealias NativeKey = SecKey
	
	public class func createPublicKey(withPEM pemString: String) throws -> PublicKey {
		
        // Get the Base64 representation of the PEM encoded string after stripping off the PEM markers
        let base64String = try CryptorRSA.base64String(for: pemString)
    
        guard let data = Data(base64Encoded: base64String, options: [.ignoreUnknownCharacters]) else {
            throw Error(code: ERR_INIT_PK, reason: "Couldn't decode base64 string")
        }
        
        return try PublicKey(with: data)
	}
	
	public class RSAKey {
		
		public let pemString: String
        internal let reference: NativeKey
        
		internal init(with data: Data) throws {
			
			var data = data
			
			// If data is a PEM String, strip the headers and convert to der.
			if let pemString = String(data: data, encoding: .utf8),
				let base64String = try? CryptorRSA.base64String(for: pemString),
				let base64Data = Data(base64Encoded: base64String) {
				data = base64Data
			}
			data = try CryptorRSA.stripX509CertificateHeader(for: data)
			self.pemString = CryptorRSA.convertDerToPem(from: data)
            reference = try CryptorRSA.createKey(from: data)
		}
	}
    
	public class PublicKey: RSAKey {}
	
}
