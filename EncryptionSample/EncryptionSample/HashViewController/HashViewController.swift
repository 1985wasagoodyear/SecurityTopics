//
//  HashViewController.swift
//  Created 8/21/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit
import CommonCrypto

class HashViewController: UIViewController {

    // MARK: - Storyboard Outlets
    
    @IBOutlet var stringInputTextField: UITextField! {
        didSet {
            stringInputTextField.delegate = self
            stringInputTextField.returnKeyType = .done
        }
    }
    @IBOutlet var algInputTextField: UITextField! {
        didSet {
            algInputTextField.delegate = self
        }
    }
    @IBOutlet var algPickerView: UIPickerView! {
        didSet {
            algPickerView.dataSource = self
            algPickerView.delegate = self
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done",
                                             style: .done,
                                             target: self,
                                             action: #selector(selectedPickerValue))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                              target: nil,
                                              action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel",
                                               style: .plain,
                                               target: self,
                                               action: #selector(cancelPickerSelection))
            
            toolBar.setItems([cancelButton, spaceButton, doneButton],
                             animated: false)
            toolBar.isUserInteractionEnabled = true
            
            algInputTextField.inputView = algPickerView
            algInputTextField.inputAccessoryView = toolBar
        }
    }
    @IBOutlet var algPickerTopConstraint: NSLayoutConstraint!
    @IBOutlet var hashedOutputTextView: UITextView! {
        didSet {
            let layer = hashedOutputTextView.layer
            layer.borderColor = UIColor(white: 0.0, alpha: 0.2).cgColor
            layer.borderWidth = 1.0
            layer.cornerRadius = 8.0
        }
    }
    
    lazy var endEdittingTapGesture: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(endEditingTapAction))
    }()
    
    var selectedAlgIndex = -1
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(endEdittingTapGesture)
    }
    
    func updateOutputTextField() {
        guard let inputString = stringInputTextField.text,
            inputString.isEmpty == false,
            let data = inputString.data(using: .utf8),
            selectedAlgIndex > 0 else {
            hashedOutputTextView.text = ""
            return
        }
        
        let hashed = CommCrypto
            .allCases[selectedAlgIndex]
            .hash(data: data)
        hashedOutputTextView.text = hashed.toHexString().uppercased()
    }

}
