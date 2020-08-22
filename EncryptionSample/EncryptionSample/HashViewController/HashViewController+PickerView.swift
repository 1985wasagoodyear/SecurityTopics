//
//  HashViewController+PickerView.swift
//  Created 8/22/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit

extension HashViewController {
    
    func showPicker() {
        algPickerTopConstraint.constant = -algPickerView.frame.size.height - 100.0
    }
    
    func hidePicker() {
        algPickerTopConstraint.constant = 0.0
        if selectedAlgIndex > 0 {
            algInputTextField.text = CommCrypto
                .allCases[selectedAlgIndex]
                .rawValue
        }
    }
    
}

extension HashViewController: UIPickerViewDelegate {
    
    @objc func selectedPickerValue() {
        selectedAlgIndex = algPickerView.selectedRow(inComponent: 0)
        hidePicker()
        algInputTextField.resignFirstResponder()
        updateOutputTextField()
    }
    
    @objc func cancelPickerSelection() {
        hidePicker()
        algInputTextField.resignFirstResponder()
    }
    
    @objc func endEditingTapAction() {
        hidePicker()
        view.endEditing(true)
    }
    
}

extension HashViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        CommCrypto.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        CommCrypto.allCases[row].rawValue
    }
    
}

