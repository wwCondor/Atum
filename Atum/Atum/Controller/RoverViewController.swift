//
//  RoverViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RoverViewController: UIViewController {
    
//    let pageControl = PageControl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemOrange //UIColor(named: .appBackgroundColor)
        
        setupNavigationBarItems()
        setupViews()
        
    }
    
    private func setupViews() {
        
    }
    
    private func setupNavigationBarItems() {
//        let navigatonBarImage = UIImage(named: .arrowIcon)!.withRenderingMode(.alwaysTemplate)
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = navigatonBarImage
//        self.navigationController?.navigationBar.backIndicatorImage = navigatonBarImage
    }
}
