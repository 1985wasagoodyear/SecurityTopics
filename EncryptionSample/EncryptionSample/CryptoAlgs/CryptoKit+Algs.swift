//
//  CryptoKit+Algs.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation
import CryptoKit

/*
 https://8gwifi.org/CipherFunctions.jsp
 */
// not really sure how this works, yet...
// https://www.raulferrergarcia.com/en/cryptokit-tutorial-how-to-use-cryptokit-on-ios13-apps/
// maybe? need to look at this more, later.
extension Data {
    
    func encrypt(key: Data) throws -> Data {
        try CryptoKit.AES.GCM.seal(self, using: SymmetricKey(data: key)).ciphertext
    }
    
    func decrypt(key: Data) throws -> Data {
        let combined = try AES.GCM.SealedBox(combined: self)
        return try CryptoKit.AES.GCM.open(combined,
                               using: SymmetricKey(data: key))
    }
}


