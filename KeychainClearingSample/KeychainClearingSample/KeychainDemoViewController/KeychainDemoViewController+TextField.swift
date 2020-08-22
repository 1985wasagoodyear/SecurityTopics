//
//  KeychainDemoViewController+TextField.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit

extension KeychainDemoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enableSaveButtonIfNeeded()
        textField.resignFirstResponder()
        return true
    }
    
}

