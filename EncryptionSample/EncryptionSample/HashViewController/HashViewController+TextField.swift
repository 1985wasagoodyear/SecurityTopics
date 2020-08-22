//
//  HashViewController+TextField.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit

extension HashViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard algInputTextField === textField else {
            hidePicker()
            algInputTextField.resignFirstResponder()
            return
        }
        showPicker()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard stringInputTextField === textField else { return }
        updateOutputTextField()
        stringInputTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

