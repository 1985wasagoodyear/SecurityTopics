//
//  KeychainDemoViewController+Keychain.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

extension KeychainDemoViewController {
    
    var usernameKeychain: BasicKeychain {
        BasicKeychain(name: ConstantKeys.username,
                      service: ConstantKeys.serviceName)
    }
    
    var passwordKeychain: BasicKeychain {
        BasicKeychain(name: ConstantKeys.password,
                      service: ConstantKeys.serviceName)
    }
    
    func setupInitialUIFromPersistedData() {
        if UserDefaults.standard.bool(forKey: ConstantKeys.didRememberMe) {
            usernameTextField.text = try? usernameKeychain.get()
            passwordTextField.text = try? passwordKeychain.get()
            enableSaveUI()
            rememberMeSwitch.isOn = true
        } else {
            disableSaveUI()
            rememberMeSwitch.isOn = false
        }
    }
    
}
