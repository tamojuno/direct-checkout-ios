//
//  CryptorRSA.swift
//  CryptorRSA
//
//  Created by Bill Abt on 1/17/17.
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

import Foundation

@available(macOS 10.12, iOS 10.3, watchOS 3.3, tvOS 12.0, *)
public class CryptorRSA {
    
	public class func createPlaintext(with data: Data) -> PlaintextData {
		
		return PlaintextData(with: data)
	}
    
	public class RSAData {
		
		public enum DataType {
            case plaintextType
            case encryptedType
		}
        
		public let data: Data
		public internal(set) var type: DataType = .plaintextType
        public var base64String: String {
            return data.base64EncodedString()
        }
        
		internal init(with data: Data, type: DataType) {
			self.data = data
			self.type = type
		}
        
		public func encrypted(with key: PublicKey) throws -> EncryptedData? {
			
			guard self.type == .plaintextType else {
				throw Error(code: CryptorRSA.ERR_NOT_PLAINTEXT, reason: "Data is not plaintext")
			}

            var response: Unmanaged<CFError>? = nil
            let eData = SecKeyCreateEncryptedData(key.reference, .rsaEncryptionOAEPSHA256, self.data as CFData, &response)
            if response != nil {
                guard let error = response?.takeRetainedValue() else {
                    throw Error(code: CryptorRSA.ERR_ENCRYPTION_FAILED, reason: "Encryption failed. Unable to determine error.")
                }
            
                throw Error(code: CryptorRSA.ERR_ENCRYPTION_FAILED, reason: "Encryption failed with error: \(error)")
            }

            return EncryptedData(with: eData! as Data)
		}
		
	}
	
	public class PlaintextData: RSAData {
        
		internal init(with data: Data) {
			super.init(with: data, type: .plaintextType)
		}
        
	}
    
	public class EncryptedData: RSAData {
        
		public init(with data: Data) {
			super.init(with: data, type: .encryptedType)
		}
        
	}
	
}

