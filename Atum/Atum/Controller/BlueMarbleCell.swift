//
//  BlueMarblePuzzleCell.swift
//  Atum
//
//  Created by Wouter Willebrands on 30/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class BlueMarbleCell: BaseCell {
    
    var allNaturalDates = [String]()

    lazy var cellContentView: CellContentView = {
        let cellContentView = CellContentView()
        cellContentView.backgroundColor = UIColor(named: .appBackgroundColor)
        return cellContentView
    }()

    // Selected Image
    lazy var selectedImageView: UIImageView = {
        let image = UIImage(named: .marbleImagePlaceholder)
        let selectedImageView = UIImageView(image: image)
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.backgroundColor = UIColor.yellow
        selectedImageView.layer.masksToBounds = true
        selectedImageView.layer.cornerRadius = Constant.largeCornerRadius
        return selectedImageView
    }()
    
    // Image MetaData
    lazy var greetingTextField: PostcardGreetingField = {
        let greetingTextField = PostcardGreetingField()
        greetingTextField.text = "Greetings from Mars!"
        return greetingTextField
    }()
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
    
    lazy var naturalDatePicker: UIPickerView = {
        let naturalDatePicker = UIPickerView()
        naturalDatePicker.translatesAutoresizingMaskIntoConstraints = false
        naturalDatePicker.backgroundColor = UIColor.clear
        naturalDatePicker.delegate = self
        naturalDatePicker.dataSource = self
        return naturalDatePicker
    }()
    
    lazy var startPuzzleButton: CustomButton = {
        let startPuzzleButton = CustomButton(type: .custom)
        let image = UIImage(named: .sendIcon)?.withRenderingMode(.alwaysTemplate)
        let inset: CGFloat = Constant.sendButtonIconInset
        startPuzzleButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        startPuzzleButton.setImage(image, for: .normal)
        startPuzzleButton.addTarget(self, action: #selector(sendPostcard(tapGestureRecognizer:)), for: .touchUpInside)
        startPuzzleButton.layer.masksToBounds = true
        startPuzzleButton.layer.cornerRadius = Constant.smallCornerRadius
        startPuzzleButton.layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        startPuzzleButton.layer.borderWidth = Constant.sendButtonBorderWidth
        return startPuzzleButton
    }()

    override func setupView() {
//        createSolArrays()
        addSubview(cellContentView)
        
        // selectedImageContainerView content
        cellContentView.addSubview(leftNavigator)
        cellContentView.addSubview(selectedImageView)
        cellContentView.addSubview(rightNavigator)
        
        cellContentView.addSubview(startPuzzleButton)

        cellContentView.addSubview(naturalDatePicker)

        
        // Meta Data TextFields
//        cellContentView.addSubview(greetingTextField)
//        cellContentView.addSubview(roverInfoField)
//        cellContentView.addSubview(cameraInfoField)
//        cellContentView.addSubview(dateInfoField)
        
        
        let viewWidth: CGFloat = frame.width
        let selectedImageSize: CGFloat = (3/4)*frame.width
        let contentPadding: CGFloat = (viewWidth - selectedImageSize) / 2

        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        let navigatorOffset: CGFloat = 2
        

//        let navigatorHeigth = Constant.sendButtonSize
//        let navigatorWidth = navigatorHeigth / 2
//        let navigatorOffset: CGFloat = 2
        
        NSLayoutConstraint.activate([
            // view containing cell content
            cellContentView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.navigationBarHeight),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cellContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.menuBarHeight),
            
            // Current Selection
            leftNavigator.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -navigatorOffset),
            leftNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            leftNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            leftNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            selectedImageView.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: Constant.contentPadding),
            selectedImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            rightNavigator.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: navigatorOffset),
            rightNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            rightNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            rightNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
        
            startPuzzleButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            startPuzzleButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            startPuzzleButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            startPuzzleButton.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            
            naturalDatePicker.topAnchor.constraint(equalTo: startPuzzleButton.bottomAnchor, constant: Constant.contentPadding),
            naturalDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentPadding),
            naturalDatePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentPadding),
            naturalDatePicker.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -Constant.contentPadding),
            
            // Postcard metadata
//            greetingTextField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.contentSidePadding),
//            greetingTextField.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: -Constant.contentSidePadding),
//            greetingTextField.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
//            greetingTextField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
        ])
    }
    
    @objc private func sendPostcard(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Sending Email")
    }
    
    @objc private func showPreviousSuggestion() {
        print("Showing Previous Image")
    }
    
    @objc private func showNextSuggestion() {
        print("Showing Next Image")
    }
}

extension BlueMarbleCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // We have 3 search input parameters for the users: Rover, Camera and Sol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if allNaturalDates.count == 0 {
            return 100
        } else {
            return allNaturalDates.count
        }
    }
    
//     Data being returned for each column
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if allNaturalDates.count == 0 {
            return "No dates obtained"
        } else {
            return allNaturalDates[row]
        }
    }
    
    // This part updates the selected categories
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if allNaturalDates.count == 0 {
            greetingTextField.text = "No dates obtained"
        } else {
            greetingTextField.text = allNaturalDates[row]
        }
    }
    
//     MARK: Picker Customization
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = UIColor(named: .textTintColor)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        
        if allNaturalDates.count == 0 {
            label.text = "No dates obtained"
        } else {
            label.text = allNaturalDates[row]
        }
        
        return label
    }
}
