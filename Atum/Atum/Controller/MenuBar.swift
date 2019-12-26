//
//  MenuBar.swift
//  Atum
//
//  Created by Wouter Willebrands on 26/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MenuBar: UIView {

    let cellId = "menuBarCellId"
    
    let imageNames: [UIImage.Name] = [.roverIcon, .skyEyeIcon, .puzzleIcon]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        // Sets number of Cells
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
        }
        
        // Sets up cell content
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
            cell.iconContainer.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
            cell.iconContainer.tintColor = UIColor(named: .iconColor)
            return cell
        }
        
        // Sets up size of the cells
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: frame.width / 3, height: frame.height)
        }
        
        // Sets up spacing between posts
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        // Sets up what to do when a cell gets tapped
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Cell tapped")
        }
}

class MenuCell: BaseCell {
    
    let iconContainer: UIImageView = {
        let iconContainer = UIImageView()
//        iconContainer.image = UIImage(named: .roverIcon)?.withRenderingMode(.alwaysTemplate)
//        iconContainer.tintColor = UIColor(named: .iconTintColor)
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        return iconContainer
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor(named: .objectColor)
        
        addSubview(iconContainer)
        
        NSLayoutConstraint.activate([
            iconContainer.heightAnchor.constraint(equalToConstant: Constant.menuBarIconSize),
            iconContainer.widthAnchor.constraint(equalToConstant: Constant.menuBarIconSize),
            iconContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}






class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        
    }
}


    
//    lazy var roverButton: CustomButton = {
//        let roverButton = CustomButton(type: .custom)
//        let image = UIImage(named: .roverIcon)?.withRenderingMode(.alwaysTemplate)
//        roverButton.setImage(image, for: .normal)
//
////        roverButton.addTarget(self, action: #selector(enterNavigationMode(tapGestureRecognizer:)), for: .touchUpInside)
//        return roverButton
//    }()
//
//    lazy var skyEyeButton: CustomButton = {
//        let skyEyeButton = CustomButton(type: .custom)
//        let image = UIImage(named: .skyEyeIcon)?.withRenderingMode(.alwaysTemplate)
//        skyEyeButton.setImage(image, for: .normal)
//
////        skyEyeButton.addTarget(self, action: #selector(enterNavigationMode(tapGestureRecognizer:)), for: .touchUpInside)
//        return skyEyeButton
//    }()
//
//    lazy var puzzleButton: CustomButton = {
//        let puzzleButton = CustomButton(type: .custom)
//        let image = UIImage(named: .puzzleIcon)?.withRenderingMode(.alwaysTemplate)
//        puzzleButton.setImage(image, for: .normal)
//
////        puzzleButton.addTarget(self, action: #selector(enterNavigationMode(tapGestureRecognizer:)), for: .touchUpInside)
//        return puzzleButton
//    }()
