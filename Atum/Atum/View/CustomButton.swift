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
//        let inset: CGFloat = Constant.navigationBarIconInset
//        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        contentMode = .center
        backgroundColor = UIColor(named: .objectColor)
        tintColor = UIColor(named: .iconTintColor)
        imageView?.contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
//    func additionalSetup() {
//        backgroundColor?.withAlphaComponent(0.9)
//    }
}
