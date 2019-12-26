//
//  NavigationBar.swift
//  Atum
//
//  Created by Wouter Willebrands on 25/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {
    
//    lazy var roverButton: CustomButton = {
//        let roverButton = CustomButton(type: .custom)
//        let image = UIImage(named: .roverIcon)?.withRenderingMode(.alwaysTemplate)
//        roverButton.setImage(image, for: .normal)
//        //        let inset: CGFloat = 4
//        //        roverButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset + 10, right: inset + 40)
//        //        roverButton.addTarget(self, action: #selector(deleteReminder), for: .touchUpInside)
//        return roverButton
//    }()
//    
//    lazy var skyEyeButton: CustomButton = {
//        let skyEyeButton = CustomButton(type: .custom)
//        let image = UIImage(named: .skyEyeIcon)?.withRenderingMode(.alwaysTemplate)
//        skyEyeButton.setImage(image, for: .normal)
//        //        let inset: CGFloat = 4
//        //        skyEyeButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset + 10, right: inset + 40)
//        //        skyEyeButton.addTarget(self, action: #selector(deleteReminder), for: .touchUpInside)
//        return skyEyeButton
//    }()
//    
//    lazy var puzzleButton: CustomButton = {
//        let puzzleButton = CustomButton(type: .custom)
//        let image = UIImage(named: .puzzleIcon)?.withRenderingMode(.alwaysTemplate)
//        puzzleButton.setImage(image, for: .normal)
//        //        let inset: CGFloat = 4
//        //        puzzleButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset + 10, right: inset + 40)
//        //        puzzleButton.addTarget(self, action: #selector(deleteReminder), for: .touchUpInside)
//        return puzzleButton
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor(named: .objectColor)
//        
//        addSubview(roverButton)
//        addSubview(skyEyeButton)
//        addSubview(puzzleButton)
    }
    
    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            roverButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            roverButton.topAnchor.constraint(equalTo: topAnchor),
//            roverButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            roverButton.widthAnchor.constraint(equalToConstant: frame.width/3)
//        ])
    }
}
