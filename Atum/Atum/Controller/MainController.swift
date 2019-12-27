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
    
    // This will hold the image selected by user
    lazy var roverImageView: UIImageView = {
       let roverImageView = UIImageView()
       return roverImageView
    }()
    
    // Meta data for image
//    lazy var messageLabel: 
    
    lazy var roverPickerView: UIPickerView = {
        let roverPickerView = UIPickerView()
        return roverPickerView
    }()
    
    lazy var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        return datePickerView
    }()
    
    lazy var cameraPickerView: UIPickerView = {
        let cameraPickerView = UIPickerView()
        return cameraPickerView
    }()
    
    lazy var retrievedRoverCameraImages: UICollectionView = {
        let retrievedRoverCameraImages = UICollectionView()
        return retrievedRoverCameraImages
    }()
    
    
    
    lazy var menuButton: CustomButton = {
        let menuButton = CustomButton(type: .custom)
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
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()

    /*
     If there a scrollview inside the UIViewController this will run underneath the MenuBar fix by:
     scrollviewName?.contentInset = UIEdgeInsetsMake(0,0,0,0)
     scrollviewName?.scrollIndicatorInsets = UIEdgeInsetsMake(0,0,0,0) // same for scrollbar
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
        setupRocketIcon()
//        setupNavigationBarItem()
        setupMenuBar()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        return menuBar
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: Constant.navigationBarHeight)
        ])
    }
    
    private func setupRocketIcon() {
        let logoImageViewWidth = navigationController!.navigationBar.frame.size.width/3
        let logoImageHeight = navigationController!.navigationBar.frame.size.height
        logoImageView.frame = CGRect(x: 0, y: 0, width: logoImageViewWidth, height: logoImageHeight)
        navigationItem.titleView = logoImageView
    }
    
//    private func setupNavigationBarItem() {
//        let showMenuIcon = UIImage(named: .menuIcon)?.withRenderingMode(.alwaysTemplate)
//        let showMenuBarButtonItem = UIBarButtonItem(image: showMenuIcon, style: .plain, target: self, action: #selector(handleMenu))
//        navigationItem.rightBarButtonItem = showMenuBarButtonItem
//    }
    
    @objc private func handleMenu() {
        print("Menu")
    }
    
    private func setupView() {
        view.addSubview(menuButton)
                
        NSLayoutConstraint.activate([
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
        print("Whooooooshhh!")
    }
}
