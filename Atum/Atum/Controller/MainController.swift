//
//  MainController.swift
//  Atum
//
//  Created by Wouter Willebrands on 25/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    //    let slideMenuManager = SlideMenuManager()
    
    let cellId = "contentCellId"
    
    var modeSelected: ModeSelected = .marsRoverMode
    
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor(named: .appBackgroundColor)
        //        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    //    lazy var menuButton: CustomButton = {
    //        let menuButton = CustomButton(type: .custom)
    //        let menuIcon = UIImage(named: .menuIcon)?.withRenderingMode(.alwaysTemplate)
    //        menuButton.setImage(menuIcon, for: .normal)
    //        let inset: CGFloat = Constant.menuButtonIconInset
    //        menuButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    //        menuButton.addTarget(self, action: #selector(navigationMode(tapGestureRecognizer:)), for: .touchUpInside)
    //        return menuButton
    //    }()
    
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
        
        
        
        switch modeSelected {
        case .marsRoverMode:     view.backgroundColor = UIColor(named: .appBackgroundColor)
        case .eyeInTheSkyMode:   view.backgroundColor = UIColor.systemTeal
        case .slidingPuzzleMode: view.backgroundColor = UIColor.systemYellow
        }
        //        view.backgroundColor = UIColor.red //UIColor(named: .appBackgroundColor)
        
        setupRocketIcon()
        setupView()
    }
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.mainController = self // creates reference inside menuBar
        return menuBar
    }()
    
    private func setupRocketIcon() {
        let logoImageViewWidth = navigationController!.navigationBar.frame.size.width/3
        let logoImageHeight = navigationController!.navigationBar.frame.size.height
        logoImageView.frame = CGRect(x: 0, y: 0, width: logoImageViewWidth, height: logoImageHeight)
        navigationItem.titleView = logoImageView
    }
    
    
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: menuBar.topAnchor),
            
            menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: Constant.navigationBarHeight)
        ])
    }
    
    func scrollToItemAtIndex(menuSelectionIndex: Int) {
        let indexPath = IndexPath(item: menuSelectionIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    
    @objc private func handleMenu() {
        print("Menu")
    }
    
    //    private func setupView() {
    //        view.addSubview(menuButton)
    //
    //        NSLayoutConstraint.activate([
    //            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    //            menuButton.widthAnchor.constraint(equalToConstant: Constant.menuButtonSize),
    //            menuButton.heightAnchor.constraint(equalToConstant: Constant.menuButtonSize),
    //            menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.menuButtonSize),
    //        ])
    //    }
    
    @objc private func navigationMode(tapGestureRecognizer: UITapGestureRecognizer) {
        //        slideMenuManager.presentMenu()
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

extension MainController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // Sets number of Cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // number of items in menuBar
    }
    
    // Sets up cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)// as! MenuBarCell
        let backgroundColors: [UIColor] = [UIColor(named: .appBackgroundColor)!, UIColor(named: .objectBorderColor)!, UIColor(named: .textTintColor)!]
        
        cell.backgroundColor = backgroundColors[indexPath.item]
        //            if indexPath.row == 0 { // Handles preselected state
        //                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        //                cell.iconContainer.tintColor = UIColor(named: .iconSelectedColor)
        //            } else {
        //                cell.iconContainer.tintColor = UIColor(named: .iconColor)
        //            }
        //            cell.iconContainer.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    // Sets up size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // Sets up spacing between posts
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
        menuBar.horizontalSliderLeadingAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print(targetContentOffset.pointee.x / view.frame.width)
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    // Sets up what to do when a cell gets tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handles slider repositioning on cell tap
        //            let leadingConstraintX = CGFloat(indexPath.item) * frame.width/3
        //            horizontalSliderLeadingAnchorConstraint?.constant = leadingConstraintX
        //            UIView.animate(withDuration: 0.5,
        //                           delay: 0,
        //                           options: .curveEaseInOut,
        //                           animations: self.layoutIfNeeded,
        //                           completion: nil)
    }
}
