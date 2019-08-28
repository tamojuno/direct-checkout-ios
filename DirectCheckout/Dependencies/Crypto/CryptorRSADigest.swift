//
//  CryptorRSADigest.swift
//  CryptorRSA
//
//  Created by Bill Abt on 1/18/17.
//
//
//     Licensed under the Apache License, Version 2.0 (the "License");
//     you may not use this file except in compliance with the License.
//     You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//     Unless required by applicable law or agreed to in writing, software
//     distributed under the License is distributed on an "AS IS" BASIS,
//     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//     See the License for the specific language governing permissions and
//     limitations under the License.
//

import CommonCrypto
import Foundation

// MARK: -- RSA Digest Extension for Data

///
/// Digest Handling Extension
///
extension Data {
    
    // MARK: Enums
    
    ///
    /// Enumerates available Digest algorithms
    ///
    public enum Algorithm {
        
        /// Secure Hash Algorithm 2 256-bit
        case sha256
        
        @available(macOS 10.12, iOS 10.0, watchOS 3.3, tvOS 12.0, *)
        public var algorithmForEncryption: SecKeyAlgorithm {
            
            switch self {
                
            case .sha256:
                return .rsaEncryptionOAEPSHA256

            }
        }
        
    }
}

