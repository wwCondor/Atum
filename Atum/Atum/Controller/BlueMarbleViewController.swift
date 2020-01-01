//
//  BlueMarbleViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class BlueMarbleViewController: UIViewController {

//    let pageControl = PageControl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemRed //UIColor(named: .appBackgroundColor)
        
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

//extension BlueMarbleViewController: PageDelegate {
//    func pageViewController(pageViewController: PageViewController,
//        didUpdatePageCount count: Int) {
//        pageControl.numberOfPages = count
//    }
//
//    func pageViewController(pageViewController: PageViewController,
//        didUpdatePageIndex index: Int) {
//        pageControl.currentPage = index
//    }
//}
