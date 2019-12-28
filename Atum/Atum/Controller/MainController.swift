//
//  MainController.swift
//  Atum
//
//  Created by Wouter Willebrands on 25/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MainController: UIViewController {
        
    let cellIds: [String] = ["marsRoverCellId", "skyEyeCellId", "puzzleCellId"]
    
    let marsRoverCellId = "marsRoverCellId"
    let skyEyeCellId = "skyEyeCellId"
    let puzzleCellId = "puzzleCellId"
        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: .appBackgroundColor)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MarsRoverCell.self, forCellWithReuseIdentifier: cellIds[0])
        collectionView.register(EyeInSkyCell.self, forCellWithReuseIdentifier: cellIds[1])
        collectionView.register(PuzzleCell.self, forCellWithReuseIdentifier: cellIds[2])
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

//    lazy var pageViewController: UIPageViewController = {
//        let pageViewcontroller = UIPageViewController()
//        pageViewcontroller.delegate = self
//        pageViewcontroller.dataSource = self
//        return pageViewcontroller
//    }()

    
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
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
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
//        view.addSubview(pageViewController)
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIds[indexPath.item], for: indexPath)
        
        switch indexPath.item {
        case 0:
//            if let marsRoverCell = collectionView.dequeueReusableCell(withReuseIdentifier: marsRoverCellId, for: indexPath) as? MarsRoverCell {
//                return marsRoverCell
//            }
            if let marsRoverCell = cell as? MarsRoverCell {
                marsRoverCell.backgroundColor = UIColor.systemPink
            }
        case 1:
//            if let eyeInSkyCell = collectionView.dequeueReusableCell(withReuseIdentifier: skyEyeCellId, for: indexPath) as? EyeInSkyCell {
//                return eyeInSkyCell
//            }
            if let eyeInSkyCell = cell as? EyeInSkyCell {
                eyeInSkyCell.backgroundColor = UIColor.systemGray
            }
        case 2:
//            if let puzzleCell = collectionView.dequeueReusableCell(withReuseIdentifier: puzzleCellId, for: indexPath) as? PuzzleCell {
//                return puzzleCell
//            }
            if let puzzleCell = cell as? PuzzleCell {
                puzzleCell.backgroundColor = UIColor.systemBlue
            }

        default:
            break
        }
        
//        let backgroundColors: [UIColor] = [UIColor(named: .appBackgroundColor)!, UIColor(named: .objectBorderColor)!, UIColor(named: .textTintColor)!]
//
//        cell.backgroundColor = backgroundColors[indexPath.item]
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
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // Handles slider repositioning on cell tap
//        //            let leadingConstraintX = CGFloat(indexPath.item) * frame.width/3
//        //            horizontalSliderLeadingAnchorConstraint?.constant = leadingConstraintX
//        //            UIView.animate(withDuration: 0.5,
//        //                           delay: 0,
//        //                           options: .curveEaseInOut,
//        //                           animations: self.layoutIfNeeded,
//        //                           completion: nil)
//    }
}

// MARK: ROVER
class MarsRoverCell: BaseCell {
//    let modeSelected: ModeSelected = .marsRoverMode
    
        // This will hold the image selected by user
    lazy var roverImageView: UIImageView = {
        let roverImageView = UIImageView()
        roverImageView.translatesAutoresizingMaskIntoConstraints = false
        roverImageView.backgroundColor = UIColor.yellow
        roverImageView.layer.masksToBounds = true
        roverImageView.layer.cornerRadius = Constant.largeContentCornerRadius
        return roverImageView
    }()
    
    lazy var stampImageView: UIImageView = {
        let stampImageView = UIImageView()
        stampImageView.translatesAutoresizingMaskIntoConstraints = false
        stampImageView.backgroundColor = UIColor.blue
        return stampImageView
    }()
    
    lazy var test: UIImageView = {
        let test = UIImageView()
        test.translatesAutoresizingMaskIntoConstraints = false
        test.backgroundColor = UIColor.green
        return test
    }()
        
        // Meta data for image
        //    lazy var messageLabel:
        
    //    lazy var roverPickerView: UIPickerView = {
    //        let roverPickerView = UIPickerView()
    //        return roverPickerView
    //    }()
    //
    //    lazy var datePickerView: UIDatePicker = {
    //        let datePickerView = UIDatePicker()
    //        return datePickerView
    //    }()
    //
    //    lazy var cameraPickerView: UIPickerView = {
    //        let cameraPickerView = UIPickerView()
    //        return cameraPickerView
    //    }()
    //
    //    lazy var retrievedRoverCameraImages: UICollectionView = {
    //        let retrievedRoverCameraImages = UICollectionView()
    //        return retrievedRoverCameraImages
    //    }()
    
    override func setupView() {
        addSubview(roverImageView)
        addSubview(stampImageView)
        addSubview(test)
        
        NSLayoutConstraint.activate([
//            roverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.contentPadding),
            roverImageView.bottomAnchor.constraint(equalTo: centerYAnchor),
            roverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roverImageView.widthAnchor.constraint(equalToConstant: (3/4)*frame.width),
            roverImageView.heightAnchor.constraint(equalToConstant: frame.width/2),
            
            stampImageView.topAnchor.constraint(equalTo: roverImageView.topAnchor, constant: 15),
            stampImageView.trailingAnchor.constraint(equalTo: roverImageView.trailingAnchor, constant: -15),
            stampImageView.widthAnchor.constraint(equalToConstant: 60),
            stampImageView.heightAnchor.constraint(equalToConstant: 60),

        ])
        
    }
}


// MARK: SKYEYE
class EyeInSkyCell: BaseCell {
//    let modeSelected: ModeSelected = .eyeInTheSkyMode

    override func setupView() {

        
    }
}


// MARK: PUZZLE
class PuzzleCell: BaseCell {
//    let modeSelected: ModeSelected = .slidingPuzzleMode

    override func setupView() {

        
    }
}
