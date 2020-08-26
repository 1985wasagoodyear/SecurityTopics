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
    
    func encrypt(key: SymmetricKey) throws -> AES.GCM.SealedBox {
        try AES.GCM.seal(self, using: key)
    }
    
    func encrypt(key: Data) throws -> AES.GCM.SealedBox {
        try AES.GCM.seal(self, using: SymmetricKey(data: key))
    }
    
}

extension AES.GCM.SealedBox {
    
    func decrypt(key: SymmetricKey) throws -> Data {
        return try AES.GCM.open(self, using: key)
    }
    
    func decrypt(key: Data) throws -> Data {
        return try AES.GCM.open(self, using: SymmetricKey(data: key))
    }
    
}


