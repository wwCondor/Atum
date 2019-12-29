//
//  MarsRoverCell.swift
//  Atum
//
//  Created by Wouter Willebrands on 28/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MarsRoverCell: BaseCell {

    lazy var cellContentView: CellContentView = {
        let cellContentView = CellContentView()
        cellContentView.backgroundColor = UIColor.clear
        return cellContentView
    }()
    
    lazy var sendButttonContainerView: StackItemContainer = {
        let sendButttonContainerView = StackItemContainer()
        sendButttonContainerView.backgroundColor = UIColor.black
        return sendButttonContainerView
    }()

    // This will hold the image selected by user
    lazy var selectedImageView: UIImageView = {
        let image = UIImage(named: .placeholderImage)
        let selectedImageView = UIImageView(image: image)
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.backgroundColor = UIColor.yellow
        selectedImageView.layer.masksToBounds = true
        selectedImageView.layer.cornerRadius = Constant.largeCornerRadius
        return selectedImageView
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
        test.backgroundColor = UIColor.black
        return test
    }()
    
    lazy var leftNavigator: LeftNavigator = {
        let navigator = LeftNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPreviousSuggestion))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
    
    lazy var rightNavigator: RightNavigator = {
        let navigator = RightNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNextSuggestion))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
    
    
    lazy var test2: UIImageView = {
        let test2 = UIImageView()
        test2.translatesAutoresizingMaskIntoConstraints = false
        test2.backgroundColor = UIColor.yellow
        return test2
    }()
    
    lazy var test3: UIImageView = {
        let test3 = UIImageView()
        test3.translatesAutoresizingMaskIntoConstraints = false
        test3.backgroundColor = UIColor.black
        return test3
    }()
    
    lazy var sendButton: CustomButton = { //sendButtonIconInset
        let sendButton = CustomButton(type: .custom)
        let image = UIImage(named: .sendIcon)?.withRenderingMode(.alwaysTemplate)
        let inset: CGFloat = Constant.sendButtonIconInset
        sendButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        sendButton.setImage(image, for: .normal)
        sendButton.addTarget(self, action: #selector(sendPostcard(tapGestureRecognizer:)), for: .touchUpInside)
        sendButton.layer.masksToBounds = true
        sendButton.layer.cornerRadius = Constant.smallCornerRadius
        sendButton.layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        sendButton.layer.borderWidth = Constant.sendButtonBorderWidth
        return sendButton
    }()
    

        // Meta data for image
        //    lazy var messageLabel:
        
    lazy var roverCameraPicker: UIPickerView = {
        let roverCameraPicker = UIPickerView()
        roverCameraPicker.translatesAutoresizingMaskIntoConstraints = false
        return roverCameraPicker
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
//    lazy var datePickerView: UIDatePicker = {
//        let datePickerView = UIDatePicker()
//        datePickerView.translatesAutoresizingMaskIntoConstraints = false
//        return datePickerView
//    }()
//
//    lazy var cameraPickerView: UIPickerView = {
//        let cameraPickerView = UIPickerView()
//        cameraPickerView.translatesAutoresizingMaskIntoConstraints = false
//        return cameraPickerView
//    }()
    //
    //    lazy var retrievedRoverCameraImages: UICollectionView = {
    //        let retrievedRoverCameraImages = UICollectionView()
    //        return retrievedRoverCameraImages
    //    }()
    
    override func setupView() {
        addSubview(cellContentView)
        
        // selectedImageContainerView content
        cellContentView.addSubview(leftNavigator)
        cellContentView.addSubview(selectedImageView)
        cellContentView.addSubview(rightNavigator)
        
        // pickerContainerView content
        cellContentView.addSubview(test2) // roverCameraPicker
        cellContentView.addSubview(test3) // datePicker
        
        // sendButttonContainerView content
        cellContentView.addSubview(sendButton)
        
        let viewWidth: CGFloat = frame.width
        let selectedImageSize: CGFloat = (3/4)*frame.width
        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        let navigatorOffset: CGFloat = 2
        
        NSLayoutConstraint.activate([
            // view containing cell content
            cellContentView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.navigationBarHeight),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cellContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.menuBarHeight),
            
            // Current Selection
            selectedImageView.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: Constant.contentPadding),
            selectedImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.centerXAnchor.constraint(equalTo: cellContentView.centerXAnchor),
            
            leftNavigator.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -navigatorOffset),
            leftNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            leftNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            leftNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            rightNavigator.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: navigatorOffset),
            rightNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            rightNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            rightNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            // Pickers 
            test2.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            test2.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: Constant.contentSidePadding),
            test2.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            test2.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -Constant.contentPadding),

            test3.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            test3.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -Constant.contentSidePadding),
            test3.leadingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            test3.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -Constant.contentPadding),

            sendButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -Constant.contentPadding),
        ])
    }
    
    @objc private func sendPostcard(tapGestureRecognizer: UITapGestureRecognizer) {
//        if sendButton.isHighlighted == true {
//            sendButton.tintColor = UIColor(named: .iconSelectedColor)
//        } else {
//            sendButton.tintColor = UIColor(named: .iconColor)
//        }

        print("Sending Email")
    }
    
    @objc private func showPreviousSuggestion() {
        print("Showing Previous Image")

//        if allMovies.count > 1 {
//            if currentMovie != 0 {
//                currentMovie -= 1
//            } else {
//                currentMovie = allMovies.count - 1
//            }
//            setLabels(for: currentMovie)
//            setPosterImage(for: self.currentMovie)
//        }
    }
    
    @objc private func showNextSuggestion() {
        print("Showing Next Image")

//        if allMovies.count > 1 {
//            if currentMovie != allMovies.count - 1 {
//                currentMovie += 1
//            } else {
//                currentMovie = 0
//            }
//            setLabels(for: currentMovie)
//            setPosterImage(for: self.currentMovie)
//        }
    }
}

class StackItemContainer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = UIColor.clear
    }

}


class CellContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = UIColor.clear
    }

}
