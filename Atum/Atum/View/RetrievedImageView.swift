//
//  RetrievedImageView.swift
//  Atum
//
//  Created by Wouter Willebrands on 02/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class RetrievedImageView: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        layer.cornerRadius = Constant.largeCornerRadius
    }
}
