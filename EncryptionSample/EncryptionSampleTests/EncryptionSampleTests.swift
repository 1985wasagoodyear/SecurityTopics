//
//  EncryptionSampleTests.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import XCTest
import CryptoKit
@testable import EncryptionSample

class EncryptionSampleTests: XCTestCase {

    func test_sha256() {
        let plaintext = "Agnostic Development"
        let data = plaintext.data(using: .utf8)!
        let hashed = CommCrypto.SHA256.hash(data: data)
        let sha256String = hashed.toHexString().uppercased()
        
        XCTAssertEqual(sha256String, "E8721A6EBEA3B23768D943D075035C7819662B581E487456FDB1A7129C769188")
    }
    
    func test_md5() {
        let plaintext = "Agnostic Development"
        let data = plaintext.data(using: .utf8)!
        let hashed = CommCrypto.MD5.hash(data: data)
        let md5String = hashed.toHexString().uppercased()
        
        XCTAssertEqual(md5String, "8D84E6C45CE9044CAE90C064997ACFF1")
    }
    
    /// not sure about what the expected outcome should be, for online comparison
    /// what would the so-and-so output even be?
    func test_aes_encrypt() {
        let plaintext = "Agnostic Development"
        let data = plaintext.data(using: .utf8)!
        let key = "test_aes_encrypt".data(using: .utf8)!
        let encrypted = try! data.encrypt(key: key)
        
        XCTAssertEqual(encrypted.ciphertext.toHexString().uppercased(), "ENTBkD906G8oNXimliEP+IQpjVXdjlw+RIAwzoVkFoXhul+7")
    }

    /// doesn't work, I suspect I may need to store the nonce
    func test_aes_encrypt_and_decrypt() {
        
        let plaintext = "Agnostic Development"
        let data = plaintext.data(using: .utf8)!
        var key = "test_aes_encrypt".data(using: .utf8)!
        while key.count < 16 {
            key.insert(0, at: 0) // pad with zeros?
        }
        
        let encrypted = try! data.encrypt(key: key)
        let decrypted = try! encrypted.decrypt(key: key)
        
        let decrypedString = String(data: decrypted, encoding: .utf8)
        XCTAssertEqual(decrypedString, plaintext)
    }
    
}
