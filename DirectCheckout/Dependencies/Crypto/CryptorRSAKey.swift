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

// MARK: -

@available(macOS 10.12, iOS 10.3, watchOS 3.3, tvOS 12.0, *)
extension CryptorRSA {
	
	// MARK: Type Aliases
    
    public typealias NativeKey = SecKey
	
	// MARK: Class Functions
	
	// MARK: -- Public Key Creation
	
	///
	/// Creates a public key by extracting it from a certificate.
	///
	/// - Parameters:
	/// 	- data:				`Data` representing the certificate.
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(extractingFrom data: Data) throws -> PublicKey {
		
        // Extact the data as a base64 string...
        let str = String(data: data, encoding: .utf8)
        guard let tmp = str else {
            
            throw Error(code: ERR_CREATE_CERT_FAILED, reason: "Unable to create certificate from certificate data, incorrect format.")
        }
    
        // Get the Base64 representation of the PEM encoded string after stripping off the PEM markers...
        let base64 = try CryptorRSA.base64String(for: tmp)
        let data = Data(base64Encoded: base64)!
		
		// Call the internal function to finish up...
		return try CryptorRSA.createPublicKey(data: data)
		
	}
	
	///
	/// Creates a key with a base64-encoded string.
	///
	/// - Parameters:
	///		- base64String: 	Base64-encoded key data
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withBase64 base64String: String) throws -> PublicKey {
		
		guard let data = Data(base64Encoded: base64String, options: [.ignoreUnknownCharacters]) else {
			
			throw Error(code: ERR_INIT_PK, reason: "Couldn't decode base64 string")
		}
		
		return try PublicKey(with: data)
	}
	
	///
	/// Creates a key with a PEM string.
	///
	/// - Parameters:
	///		- pemString: 		PEM-encoded key string
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withPEM pemString: String) throws -> PublicKey {
		
        // Get the Base64 representation of the PEM encoded string after stripping off the PEM markers
        let base64String = try CryptorRSA.base64String(for: pemString)
    
        return try createPublicKey(withBase64: base64String)
		
	}
	
	///
	/// Creates a public key by extracting it from certificate data.
	///
	/// - Parameters:
	/// 	- data:				`Data` representing the certificate.
	///
	/// - Returns:				New `PublicKey` instance.
	///
	internal class func createPublicKey(data: Data) throws -> PublicKey {
		
        // Create a DER-encoded X.509 certificate object from the DER data...
        let certificateData = SecCertificateCreateWithData(nil, data as CFData)
        guard let certData = certificateData else {
            
            throw Error(code: ERR_CREATE_CERT_FAILED, reason: "Unable to create certificate from certificate data.")
        }
        
        var key: SecKey? = nil

        #if swift(>=4.2)

            if #available(macOS 10.14, iOS 12.0, watchOS 5.0, *) {
                
                key = SecCertificateCopyKey(certData)
                
            }

        #endif

        if key == nil {
            
            key = SecCertificateCopyPublicKey(certData)
            
        }

        guard let createdKey = key else {
            
            throw Error(code: ERR_EXTRACT_PUBLIC_KEY_FAILED, reason: "Unable to extract public key from data.")
        }
        
        return PublicKey(with: createdKey)
	}
	
	// MARK: -
	
	///
	/// RSA Key Creation and Handling
	///
	public class RSAKey {
		
		// MARK: Enums
		
		/// Denotes the type of key this represents.
		public enum KeyType {
			case publicType
		}
		
		/// Denotes the size of the RSA key.
		public struct KeySize {
			let bits: Int
			/// A 1024 bit RSA key. Not recommended since this may become breakable in the near future.
			public static let bits1024 = KeySize(bits: 1024)
			/// A 2048 bit RSA key. Recommended if security will not be required beyond 2030.
			public static let bits2048 = KeySize(bits: 2048)
			/// A 3072 bit RSA key. Recommended if security is required beyond 2030.
			public static let bits3072 = KeySize(bits: 3072)
			/// A 4096 bit RSA key.
			public static let bits4096 = KeySize(bits: 4096)
		}
		
		// MARK: Properties
		
		/// The RSA key as a PKCS#1 PEM String
		public let pemString: String
		
		/// The stored key
		internal let reference: NativeKey
        
		/// Represents the type of key data contained.
		public internal(set) var type: KeyType = .publicType
		
		// MARK: Initializers
		
		///
		/// Create a key using key data (in DER format).
		///
		/// - Parameters:
		///		- data: 			Key data.
		///		- type:				Type of key data.
		///
		/// - Returns:				New `RSAKey` instance.
		///
		internal init(with data: Data, type: KeyType) throws {
			
			var data = data
			
			// If data is a PEM String, strip the headers and convert to der.
			if let pemString = String(data: data, encoding: .utf8),
				let base64String = try? CryptorRSA.base64String(for: pemString),
				let base64Data = Data(base64Encoded: base64String) {
				data = base64Data
			}
			data = try CryptorRSA.stripX509CertificateHeader(for: data)
			self.pemString = CryptorRSA.convertDerToPem(from: data, type: type)
			self.type = type            
            reference = try CryptorRSA.createKey(from: data, type: type)
		}
		
		///
		/// Create a key using a native key.
		///
		/// - Parameters:
		///		- nativeKey:		Native key representation.
		///		- type:				Type of key.
		///
		/// - Returns:				New `RSAKey` instance.
		///
		internal init(with nativeKey: NativeKey, type: KeyType) {
			
			self.type = type
			self.reference = nativeKey
			self.pemString = (try? RSAKey.getPEMString(reference: nativeKey, type: type)) ?? ""
		}
		
		///
		/// Get the RSA key as a PEM String.
		///
		/// - Returns: The RSA Key in PEM format.
		///
		static func getPEMString(reference: NativeKey, type: KeyType) throws -> String {

            var error: Unmanaged<CFError>? = nil
            guard let keyBytes = SecKeyCopyExternalRepresentation(reference, &error) else {
                guard let error = error?.takeRetainedValue() else {
                    throw Error(code: ERR_INIT_PK, reason: "Couldn't read PEM String")
                }
                throw error
            }
            return CryptorRSA.convertDerToPem(from: keyBytes as Data, type: type)
		}
	}
	// MARK: -
	
	///
	/// Public Key - Represents public key data.
	///
	public class PublicKey: RSAKey {
		
		/// MARK: Statics
		
		/// Regular expression for the PK using the begin and end markers.
		static let publicKeyRegex: NSRegularExpression? = {
			
			let publicKeyRegex = "(\(CryptorRSA.PK_BEGIN_MARKER).+?\(CryptorRSA.PK_END_MARKER))"
			return try? NSRegularExpression(pattern: publicKeyRegex, options: .dotMatchesLineSeparators)
		}()
		
		// MARK: -- Initializers
		
		///
		/// Create a public key using key data.
		///
		/// - Parameters:
		///		- data: 			Key data
		///
		/// - Returns:				New `PublicKey` instance.
		///
		public init(with data: Data) throws {
			try super.init(with: data, type: .publicType)
		}
		
		///
		/// Create a key using a native key.
		///
		/// - Parameters:
		///		- nativeKey:		Native key representation.
		///
		/// - Returns:				New `PublicKey` instance.
		///
		public init(with nativeKey: NativeKey) {
			
			super.init(with: nativeKey, type: .publicType)
		}
	}
	
}
