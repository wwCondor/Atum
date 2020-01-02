//
//  CustomButton.swift
//  Atum
//
//  Created by Wouter Willebrands on 25/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        contentMode = .center
        backgroundColor = UIColor(named: .objectColor)
        imageView?.contentMode = .scaleAspectFit
        imageView?.tintColor = UIColor(named: .iconColor)
        adjustsImageWhenHighlighted = false
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = Constant.smallCornerRadius
        layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        layer.borderWidth = Constant.sendButtonBorderWidth
    }
}
