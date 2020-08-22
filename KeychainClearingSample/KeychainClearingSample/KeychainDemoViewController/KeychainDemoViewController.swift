//
//  KeychainDemoViewController.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit

class KeychainDemoViewController: UIViewController {
    
    enum ConstantKeys {
        static let didRememberMe = "didRememberMe"
        static let serviceName = "KeychainClearingSample"
        static let username = "username"
        static let password = "password"
    }

    // MARK: - Storyboard Outlets
    
    @IBOutlet var usernameTextField: UITextField! {
        didSet {
            usernameTextField.delegate = self
            usernameTextField.returnKeyType = .done
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.returnKeyType = .done
        }
    }
    @IBOutlet var rememberMeSwitch: UISwitch!
    @IBOutlet var saveToKeychainButton: UIButton!
    
    lazy var endEdittingTapGesture: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(endEditingTapAction))
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(endEdittingTapGesture)
        setupInitialUIFromPersistedData()
    }
    
    // MARK: - Custom Action Methods
    
    @objc func endEditingTapAction() {
        enableSaveButtonIfNeeded()
        view.endEditing(true)
    }

    @IBAction func rememberMeSwitchAction(_ sender: Any) {
        enableSaveButtonIfNeeded()
    }
    
    @IBAction func saveToKeychainButtonAction(_ sender: Any) {
        guard let credentials = validateCredentials(),
            rememberMeSwitch.isOn == true else {
                UserDefaults.standard.set(false, forKey: ConstantKeys.didRememberMe)
                return
        }
        do {
            try usernameKeychain.set(credentials.username)
            try passwordKeychain.set(credentials.password)
            UserDefaults.standard.set(true, forKey: ConstantKeys.didRememberMe)
            showAlert(text: "Successfully saved your credentials to Keychain!")
        }
        catch {
            showAlert(text: "Error saving to Keychain", message: error.localizedDescription)
        }
    }
    
    // MARK: - Credentials-Validation
    
    func validateCredentials() -> (username: String, password: String)? {
        guard let username = usernameTextField.text,
            username.isEmpty == false,
            let password = passwordTextField.text,
            password.isEmpty == false else {
                return nil
        }
        return (username: username, password: password)
    }
    
    // MARK: - UI-element-adjustment Methods
    
    func enableSaveButtonIfNeeded() {
        if validateCredentials() != nil {
            enableSaveUI()
        } else {
            disableSaveUI()
        }
    }
    
    func enableSaveUI() {
        rememberMeSwitch.isEnabled = true
        saveToKeychainButton.isEnabled = true
        saveToKeychainButton.alpha = 1.0
    }
    
    func disableSaveUI() {
        rememberMeSwitch.isEnabled = false
        saveToKeychainButton.isEnabled = false
        saveToKeychainButton.alpha = 0.5
    }
    
}

extension UIViewController {
    func showAlert(text: String, message: String? = nil) {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
