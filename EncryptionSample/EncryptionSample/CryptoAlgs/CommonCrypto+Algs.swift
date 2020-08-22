//
//  CommonCrypto+Algs.swift
//  Created 8/21/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation
import CommonCrypto

/*
 Some links to test your hashing results with:
 
 https://passwordsgenerator.net/md5-hash-generator/
 
 https://emn178.github.io/online-tools/sha256.html
 
 */

/// Hashing Data using the functionality provided in the `CommonCrypto` framework.
public enum CommCrypto: String, CaseIterable {
    
    /// do not use these for hashing
    case MD2, MD4, MD5
    
    /// do use (most-of) these for hashing
    case SHA1, SHA224, SHA256, SHA384, SHA512
    
    /// create a one-way cryptographic hash
    func hash(data: Data) -> Data {
        switch self {
        case .MD2:
            return md2Hash(data: data)
        case .MD4:
            return md4Hash(data: data)
        case .MD5:
            return md5Hash(data: data)
        case .SHA1:
            return sha1Hash(data: data)
        case .SHA224:
            return sha224Hash(data: data)
        case .SHA256:
            return sha256Hash(data: data)
        case .SHA384:
            return sha384Hash(data: data)
        case .SHA512:
            return sha512Hash(data: data)
        }
    }
}

public extension CommCrypto {
    
    typealias HashBody = (_ data: UnsafeRawPointer?, _ len: CC_LONG, _ md: UnsafeMutablePointer<UInt8>?) -> UnsafeMutablePointer<UInt8>?
    
    private func hashHelper(data: Data,
                            digestLength: Int,
                            hashBody: HashBody) -> Data {
        var digest = [UInt8](repeating: 0, count: digestLength)
        let hashed: UnsafeMutablePointer<UInt8>? = data.withUnsafeBytes {
            hashBody($0.baseAddress, UInt32(data.count), &digest)
        }
        return Data.init(bytes: hashed!, count: digestLength)
    }
    
    func md2Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_MD2_DIGEST_LENGTH),
                   hashBody: CC_MD2)
    }
    func md4Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_MD4_DIGEST_LENGTH),
                   hashBody: CC_MD4)
    }
    
    func md5Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_MD5_DIGEST_LENGTH),
                   hashBody: CC_MD5)
    }
    
    func sha1Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_SHA1_DIGEST_LENGTH),
                   hashBody: CC_SHA1)
    }
    
    func sha224Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_SHA224_DIGEST_LENGTH),
                   hashBody: CC_SHA224)
    }
    
    func sha256Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_SHA256_DIGEST_LENGTH),
                   hashBody: CC_SHA256)
    }
    
    func sha384Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_SHA384_DIGEST_LENGTH),
                   hashBody: CC_SHA384)
    }
    
    func sha512Hash(data: Data) -> Data {
        hashHelper(data: data,
                   digestLength: Int(CC_SHA512_DIGEST_LENGTH),
                   hashBody: CC_SHA512)
    }

}
