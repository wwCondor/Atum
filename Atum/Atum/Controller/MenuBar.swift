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
    
    var horizontalSliderLeadingAnchorConstraint: NSLayoutConstraint?
    var mainController: MainController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var horizontalSliderBar: UIView = {
        let horizontalSliderBar = UIView()
        horizontalSliderBar.backgroundColor = UIColor(named: .iconSliderColor)
        horizontalSliderBar.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalSliderBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHorizontalBar()

        translatesAutoresizingMaskIntoConstraints = false // menuBar
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
    
    private func setupHorizontalBar() {
        addSubview(horizontalSliderBar)
        
        horizontalSliderLeadingAnchorConstraint = horizontalSliderBar.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        NSLayoutConstraint.activate([
            horizontalSliderLeadingAnchorConstraint!,
            horizontalSliderBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalSliderBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            horizontalSliderBar.heightAnchor.constraint(equalToConstant: Constant.horizontalSliderHeigth)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
            if indexPath.row == 0 { // Handles preselected state
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                cell.iconContainer.tintColor = UIColor(named: .iconSelectedColor)
            } else {
                cell.iconContainer.tintColor = UIColor(named: .iconColor)
            }
            cell.iconContainer.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
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
            // Handles slider repositioning on cell tap
//            let leadingConstraintX = CGFloat(indexPath.item) * frame.width/3
//            horizontalSliderLeadingAnchorConstraint?.constant = leadingConstraintX
//            UIView.animate(withDuration: 0.5,
//                           delay: 0,
//                           options: .curveEaseInOut,
//                           animations: self.layoutIfNeeded,
//                           completion: nil)
            mainController?.scrollToItemAtIndex(menuSelectionIndex: indexPath.item)
        }
}

class MenuBarCell: BaseCell {
    
    let iconContainer: UIImageView = {
        let iconContainer = UIImageView()
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        return iconContainer
    }()
    
    override var isHighlighted: Bool {
        didSet {
            iconContainer.tintColor = isHighlighted ? UIColor(named: .iconSelectedColor) : UIColor(named: .iconColor)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            iconContainer.tintColor = isSelected ? UIColor(named: .iconSelectedColor) : UIColor(named: .iconColor)
        }
    }
    
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
    
    func setupView() { }
}
