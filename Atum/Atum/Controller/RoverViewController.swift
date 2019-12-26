//
//  ViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 24/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RoverViewController: UIViewController {
    
    var modeSelected: ModeSelected = .marsRoverMode
    
//    lazy var roverView: UIView = {
//        let roverView = UIView()
//        roverView.translatesAutoresizingMaskIntoConstraints = false
//        roverView.backgroundColor = UIColor.systemTeal
//        return roverView
//    }()
//
//    lazy var eyeInTheSkyView: UIView = {
//        let eyeInTheSkyView = UIView()
//        eyeInTheSkyView.translatesAutoresizingMaskIntoConstraints = false
//        eyeInTheSkyView.backgroundColor = UIColor.systemOrange
//        return eyeInTheSkyView
//    }()
//
//    lazy var puzzleView: UIView = {
//        let puzzleView = UIView()
//        puzzleView.translatesAutoresizingMaskIntoConstraints = false
//        puzzleView.backgroundColor = UIColor.systemYellow
//        return puzzleView
//    }()
    
    lazy var menuButton: CustomButton = {
        let menuButton = CustomButton(type: .custom)
        let image = UIImage(named: .roverIcon)?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(image, for: .normal)

        menuButton.addTarget(self, action: #selector(enterNavigationMode(tapGestureRecognizer:)), for: .touchUpInside)
        return menuButton
    }()
    
    lazy var roverButton: CustomButton = {
        let roverButton = CustomButton(type: .custom)
        let image = UIImage(named: .roverIcon)?.withRenderingMode(.alwaysTemplate)
        roverButton.setImage(image, for: .normal)

        roverButton.addTarget(self, action: #selector(enterNavigationMode(tapGestureRecognizer:)), for: .touchUpInside)
        return roverButton
    }()
    
    lazy var skyEyeButton: CustomButton = {
        let skyEyeButton = CustomButton(type: .custom)
        let image = UIImage(named: .skyEyeIcon)?.withRenderingMode(.alwaysTemplate)
        skyEyeButton.setImage(image, for: .normal)

        skyEyeButton.addTarget(self, action: #selector(enterNavigationMode(tapGestureRecognizer:)), for: .touchUpInside)
        return skyEyeButton
    }()
    
    lazy var puzzleButton: CustomButton = {
        let puzzleButton = CustomButton(type: .custom)
        let image = UIImage(named: .puzzleIcon)?.withRenderingMode(.alwaysTemplate)
        puzzleButton.setImage(image, for: .normal)

        puzzleButton.addTarget(self, action: #selector(enterNavigationMode(tapGestureRecognizer:)), for: .touchUpInside)
        return puzzleButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)

        setupView()
//        setupNavigationBarItems()
    }

    
    private func setupNavigationBarItems() {
        navigationItem.setHidesBackButton(true, animated: true)
        let roverButtonItem = UIBarButtonItem(customView: roverButton)
        let skyEyeButtonItem = UIBarButtonItem(customView: skyEyeButton)
        let puzzleButtonItem = UIBarButtonItem(customView: puzzleButton)
        navigationItem.rightBarButtonItems = [puzzleButtonItem, skyEyeButtonItem, roverButtonItem]
//        navigationItem.leftBarButtonItem = roverButtonItem
//        navigationItem.rightBarButtonItem = skyEyeButtonItem
//        navigationItem.rightBarButtonItem = puzzleButtonItem
//        let barButtonItems = UIBarButtonItem(customView: navigationBarItems)
//        navigationItem.rightBarButtonItem = barButtonItems
    }
    
    private func setupView() {
//        view.addSubview(roverButton)
//        view.addSubview(skyEyeButton)
//        view.addSubview(puzzleButton)
//
//        NSLayoutConstraint.activate([
//            roverButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            roverButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            roverButton.heightAnchor.constraint(equalToConstant: Constant.navigationBarHeight),
//            roverButton.widthAnchor.constraint(equalToConstant: view.bounds.width * (1/3)),
//
//            skyEyeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            skyEyeButton.leadingAnchor.constraint(equalTo: roverButton.trailingAnchor),
//            skyEyeButton.heightAnchor.constraint(equalToConstant: Constant.navigationBarHeight),
//            skyEyeButton.widthAnchor.constraint(equalToConstant: view.bounds.width * (1/3)),
//
//            puzzleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            puzzleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            puzzleButton.heightAnchor.constraint(equalToConstant: Constant.navigationBarHeight),
//            puzzleButton.widthAnchor.constraint(equalToConstant: view.bounds.width * (1/3)),
//
//        ])
        
        //        view.addSubview(navigationBar)
        //
        //        NSLayoutConstraint.activate([
        //            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
        //            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //            navigationBar.heightAnchor.constraint(equalToConstant: 2*Constant.navigationBarHeight)
        //        ])
    }

    // newViewController.modalPresentationStyle = .fullScreen
    
    @objc func handleMenu(tapGestureRecognizer: UITapGestureRecognizer) {
        
    }

    
    @objc func enterNavigationMode(tapGestureRecognizer: UITapGestureRecognizer) {
        switch tapGestureRecognizer {
        case roverButton:
            modeSelected = .marsRoverMode
        case skyEyeButton:
            modeSelected = .eyeInTheSkyMode
        case puzzleButton:
            modeSelected = .slidingPuzzleMode
        default:
            break
        }
        print("Activating \(modeSelected.name) mode")

    }
}

