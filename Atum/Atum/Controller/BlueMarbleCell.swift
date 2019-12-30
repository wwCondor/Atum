//
//  BlueMarblePuzzleCell.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class BlueMarbleCell: BaseCell {

    lazy var cellContentView: CellContentView = {
        let cellContentView = CellContentView()
        cellContentView.backgroundColor = UIColor.clear
        return cellContentView
    }()

    // Selected Image
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
    
    // Image MetaData
//    lazy var greetingTextField: PostcardGreetingField = {
//        let greetingTextField = PostcardGreetingField()
//        greetingTextField.text = "Greetings from Mars!"
//        return greetingTextField
//    }()
//
//    lazy var roverInfoField: PostcardImageInfoField = {
//        let roverInfoField = PostcardImageInfoField()
//        roverInfoField.text = "Curiosity"
//        return roverInfoField
//    }()
//
//    lazy var cameraInfoField: PostcardImageInfoField = {
//        let cameraInfoField = PostcardImageInfoField()
//        cameraInfoField.text = "FHAZ"
//        return cameraInfoField
//    }()
//
//    lazy var dateInfoField: PostcardImageInfoField = {
//        let dateInfoField = PostcardImageInfoField()
//        dateInfoField.text = "2012-08-06"
//        return dateInfoField
//    }()
    
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
    
    lazy var sendButton: CustomButton = {
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

    override func setupView() {
//        createSolArrays()
        addSubview(cellContentView)
        
        // selectedImageContainerView content
        cellContentView.addSubview(leftNavigator)
        cellContentView.addSubview(selectedImageView)
        cellContentView.addSubview(rightNavigator)
        
        // Meta Data TextFields
//        cellContentView.addSubview(greetingTextField)
//        cellContentView.addSubview(roverInfoField)
//        cellContentView.addSubview(cameraInfoField)
//        cellContentView.addSubview(dateInfoField)
        
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
            selectedImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            selectedImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            leftNavigator.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -navigatorOffset),
            leftNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            leftNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            leftNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            rightNavigator.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: navigatorOffset),
            rightNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            rightNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            rightNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            // Postcard metadata
//            greetingTextField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.contentSidePadding),
//            greetingTextField.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: -Constant.contentSidePadding),
//            greetingTextField.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
//            greetingTextField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
//
//            roverInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.textFieldPadding),
//            roverInfoField.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
//            roverInfoField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
//            roverInfoField.bottomAnchor.constraint(equalTo: cameraInfoField.topAnchor),
//
//            cameraInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.textFieldPadding),
//            cameraInfoField.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
//            cameraInfoField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
//            cameraInfoField.bottomAnchor.constraint(equalTo: dateInfoField.topAnchor),
//
//            dateInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.textFieldPadding),
//            dateInfoField.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
//            dateInfoField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
//            dateInfoField.bottomAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: -Constant.textFieldPadding),

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
