//
//  TextField.swift
//  Atum
//
//  Created by Wouter Willebrands on 27/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    // Used for entering text
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        additionalSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        additionalSettings()
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor(named: .textTintColor)
        keyboardAppearance = .dark
        returnKeyType = UIReturnKeyType.done
    }
    
    func additionalSettings() { }
}

class PhotoCountInfoField: CustomTextField {
    override func additionalSettings() {
        backgroundColor = UIColor(named: .iconColor)
        layer.masksToBounds = true
        layer.cornerRadius = Constant.photoCountCornerRadius
        isUserInteractionEnabled = false
        font = UIFont.systemFont(ofSize: 10.0, weight: .medium)
        textAlignment = .center
    }
}

class PostcardGreetingField: CustomTextField {
    override func additionalSettings() {
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        layer.cornerRadius = Constant.smallCornerRadius
        isUserInteractionEnabled = true
        font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        textAlignment = .center
    }
}

class PostcardImageInfoField: CustomTextField {
    override func additionalSettings() {
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        textAlignment = .left
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constant.textXInset, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constant.textXInset, dy: 0)
    }
}

//layer.masksToBounds = true
//layer.cornerRadius = Constant.smallCornerRadius


class EmailInputField: CustomTextField {
    override func additionalSettings() {
        autocapitalizationType = UITextAutocapitalizationType.none
        autocorrectionType = UITextAutocorrectionType.no
        spellCheckingType = UITextSpellCheckingType.no
        textColor = UIColor(named: .textTintColor)
        backgroundColor = UIColor(named: .appBackgroundColor)
        layer.masksToBounds = true
        layer.cornerRadius = Constant.smallCornerRadius
        layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        layer.borderWidth = Constant.sendButtonBorderWidth
        isUserInteractionEnabled = true
        font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        textAlignment = .left
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constant.textXInset, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constant.textXInset, dy: 0)
    }
}
