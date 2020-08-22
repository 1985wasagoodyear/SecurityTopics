//
//  Data+Utility.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

extension Data {
    func toHexString() -> String {
        map { String(format: "%02hhx", $0) }.joined()
    }
}
