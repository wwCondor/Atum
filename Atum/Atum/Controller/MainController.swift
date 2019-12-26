//
//  MainController.swift
//  Atum
//
//  Created by Wouter Willebrands on 25/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    let slideMenuManager = SlideMenuManager()
    
    lazy var menuButton: CustomButton = {
        let menuButton = CustomButton(type: .custom)
//        menuButton.layer.masksToBounds = true
//        menuButton.roundButtonCorners(corners: [], radius: Constant.menuButtonCornerRadius)
//        menuButton.backgroundColor = UIColor.systemYellow
        let menuIcon = UIImage(named: .menuIcon)?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(menuIcon, for: .normal)
        let inset: CGFloat = Constant.menuButtonIconInset
        menuButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        menuButton.addTarget(self, action: #selector(navigationMode(tapGestureRecognizer:)), for: .touchUpInside)
        return menuButton
    }()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: .inactiveRocketIcon)?.withRenderingMode(.alwaysOriginal).withBottomInset(inset: 70)
        let logoImageView = UIImageView(image: image)
        logoImageView.isUserInteractionEnabled = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(activateRocket(sender:)))
        logoImageView.addGestureRecognizer(tapGesture)
//        let inset: CGFloat = 0
//        logoImageView = UIEdgeInsets(top: inset, left: inset, bottom: 5, right: inset)
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
        setupRocketIcon()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupRocketIcon() {
//        navigationItem.setHidesBackButton(true, animated: true)
//        let menuBarButton = UIBarButtonItem(customView: menuButton)
//        navigationItem.leftBarButtonItem = menuBarButton
        let logoImageViewWidth = navigationController!.navigationBar.frame.size.width/3
        let logoImageHeight = navigationController!.navigationBar.frame.size.height
        logoImageView.frame = CGRect(x: 0, y: 0, width: logoImageViewWidth, height: logoImageHeight)
        navigationItem.titleView = logoImageView
    }
    
    private func setupView() {
        view.addSubview(menuButton)
//        menuView.addSubview(menuButton)
        
//        menuButton.roundViewCorners(corners: .topRight, radius: Constant.menuButtonCornerRadius)
                
        NSLayoutConstraint.activate([
//            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            menuView.heightAnchor.constraint(equalToConstant: Constant.menuButtonHeight),
//            menuView.widthAnchor.constraint(equalToConstant: view.bounds.width/6),
//            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.menuButtonHeight),
            
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: Constant.menuButtonSize),
            menuButton.heightAnchor.constraint(equalToConstant: Constant.menuButtonSize),
            menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.menuButtonSize),
        ])
    }

    @objc private func navigationMode(tapGestureRecognizer: UITapGestureRecognizer) {
        slideMenuManager.presentMenu()
        print("Entering navigation Mode")
    }
    
    @objc private func activateRocket(sender: UITapGestureRecognizer) {
        // In here we have an ignition sound
        // image change to activeRocketIcon
        // motion departure
        // motion arriving
        
//        UIView.animate(withDuration: 3.0,
//                       delay: 0.5,
//                       options: .curveEaseIn,
//                       animations: ,
//                       completion: )
        print("Whooooooshhh!")
    }
}
