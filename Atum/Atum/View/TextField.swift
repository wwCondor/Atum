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

//class PositionInfoField: CustomTextField {
//    override func additionalSettings() {
//        layer.masksToBounds = true
//        layer.cornerRadius = Constant.smallCornerRadius
//        isUserInteractionEnabled = false
//        font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
//        textAlignment = .left
//    }
//}

// max 25 characters, so 20 should be safe for all sizes
class PostcardGreetingField: CustomTextField {
    override func additionalSettings() {
        backgroundColor = UIColor.clear//.withAlphaComponent(0.2)
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

class EmailInputField: CustomTextField {
    override func additionalSettings() {
        autocapitalizationType = UITextAutocapitalizationType.none
        textColor = UIColor(named: .textTintColor)
        backgroundColor = UIColor(named: .appBackgroundColor)
        layer.masksToBounds = true
        layer.cornerRadius = Constant.smallCornerRadius
        isUserInteractionEnabled = true
        font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        textAlignment = .left
//        attributedPlaceholder = NSAttributedString(string: "placeholder text", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: .textTintColor)!]) // Handles placeholder text color
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constant.textXInset, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constant.textXInset, dy: 0)
    }
}
