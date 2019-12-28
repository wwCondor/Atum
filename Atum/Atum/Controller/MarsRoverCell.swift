//
//  MarsRoverCell.swift
//  Atum
//
//  Created by Wouter Willebrands on 28/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MarsRoverCell: BaseCell {
//    let modeSelected: ModeSelected = .marsRoverMode
    lazy var postCardView: UIView = {
        let postCardView = UIView()
        return postCardView
    }()
    
    lazy var selectedImageContainerView: StackViewCell = {
        let selectedImageContainerView = StackViewCell()
        selectedImageContainerView.backgroundColor = UIColor.systemGreen
        return selectedImageContainerView
    }()
    
    lazy var view2: StackViewCell = {
        let view2 = StackViewCell()
        view2.backgroundColor = UIColor.systemTeal
        return view2
    }()
    
    lazy var view3: StackViewCell = {
        let view3 = StackViewCell()
        view3.backgroundColor = UIColor.systemYellow
        return view3
    }()
    
    lazy var view4: StackViewCell = {
        let view4 = StackViewCell()
        view4.backgroundColor = UIColor.systemBlue
        return view4
    }()
    
    lazy var view5: StackViewCell = {
        let view5 = StackViewCell()
        view5.backgroundColor = UIColor.systemGray
        return view5
    }()
    
    lazy var view6: StackViewCell = {
        let view6 = StackViewCell()
        view6.backgroundColor = UIColor.systemOrange
        return view6
    }()
    
    lazy var view7: StackViewCell = {
        let view7 = StackViewCell()
        view7.backgroundColor = UIColor.systemBlue
        return view7
    }()
    
    lazy var sendButttonContainerView: StackViewCell = {
        let sendButttonContainerView = StackViewCell()
        sendButttonContainerView.backgroundColor = UIColor.black
        return sendButttonContainerView
    }()
    
    lazy var cellContentStackView: UIStackView = {
        let cellContentStackView = UIStackView()
        cellContentStackView.axis = .vertical
        cellContentStackView.distribution = .fillProportionally
        cellContentStackView.translatesAutoresizingMaskIntoConstraints = false
        return cellContentStackView
    }()
    

        // This will hold the image selected by user
    lazy var selectedImageView: UIImageView = {
        let image = UIImage(named: .placeholderImage)
        let selectedImageView = UIImageView(image: image)
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.backgroundColor = UIColor.yellow
        selectedImageView.layer.masksToBounds = true
        selectedImageView.layer.cornerRadius = Constant.largeContentCornerRadius
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
    
    lazy var imageSelectionItemsContainer: UIStackView = {
        let imageSelectionItemsContainer = UIStackView()
        imageSelectionItemsContainer.axis = .horizontal
        imageSelectionItemsContainer.distribution = .fillEqually
        imageSelectionItemsContainer.translatesAutoresizingMaskIntoConstraints = false
        return imageSelectionItemsContainer
    }()
    
    lazy var pickerContainerView: UIStackView = {
        let pickerContainerView = UIStackView()
        pickerContainerView.axis = .horizontal
        pickerContainerView.distribution = .fillEqually
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerContainerView
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
    
    lazy var postcardOptionImage: UIImageView = {
        let postcardOptionImage = UIImageView()
        postcardOptionImage.translatesAutoresizingMaskIntoConstraints = false
        postcardOptionImage.backgroundColor = UIColor.systemOrange
        return postcardOptionImage
    }()
    
    lazy var test2: UIImageView = {
        let test2 = UIImageView()
        test2.translatesAutoresizingMaskIntoConstraints = false
        test2.backgroundColor = UIColor.black
        return test2
    }()
    
    lazy var test3: UIImageView = {
        let test3 = UIImageView()
        test3.translatesAutoresizingMaskIntoConstraints = false
        test3.backgroundColor = UIColor.black
        return test3
    }()
    
    lazy var sendButton: CustomButton = {
        let sendButton = CustomButton(type: .custom)
        let image = UIImage(named: .roverIcon)?.withRenderingMode(.alwaysTemplate)
        sendButton.setImage(image, for: .normal)
        sendButton.addTarget(self, action: #selector(sendPostcard(tapGestureRecognizer:)), for: .touchUpInside)
        return sendButton
    }()
    

        // Meta data for image
        //    lazy var messageLabel:
        
    lazy var filterOptionsPicker: UIPickerView = {
        let filterOptionsPicker = UIPickerView()
        filterOptionsPicker.translatesAutoresizingMaskIntoConstraints = false
        return filterOptionsPicker
    }()
    
    lazy var dateFilterPicker: UIDatePicker = {
        let datePickerView = UIDatePicker()
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        return datePickerView
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
        // Main stack
        addSubview(cellContentStackView)

        // Main container views
        cellContentStackView.addArrangedSubview(selectedImageContainerView)
//        cellContentStackView.addArrangedSubview(imageSelectionItemsContainer)
        cellContentStackView.addArrangedSubview(pickerContainerView)
        cellContentStackView.addArrangedSubview(sendButttonContainerView)

        // Sub container views
//        imageSelectionItemsContainer.addArrangedSubview(view2) // navigator left
//        imageSelectionItemsContainer.addArrangedSubview(view3) // thumbnail image option
//        imageSelectionItemsContainer.addArrangedSubview(view4) // navigator left
        
        pickerContainerView.addArrangedSubview(view5) // roverPicker
        pickerContainerView.addArrangedSubview(view6) // date/solPicker
        pickerContainerView.addArrangedSubview(view7) // cameraPicker
        
        // Container content
        addSubview(selectedImageView) // image for seleced postcard
//        addSubview(leftNavigator)
//        addSubview(rightNavigator)
        addSubview(sendButton)

//        postcardSelectionStackView.addArrangedSubview(leftNavigator)
//        postcardSelectionStackView.addArrangedSubview(postcardOptionImage)
//        postcardSelectionStackView.addArrangedSubview(rightNavigator)

//        addSubview(roverImageView)
//        addSubview(stampImageView)
//        addSubview(test)
        
        NSLayoutConstraint.activate([
            cellContentStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.menuButtonSize),
            cellContentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cellContentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cellContentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.menuButtonSize),
            
            // Replace with selected postcard
            selectedImageView.topAnchor.constraint(equalTo: selectedImageContainerView.topAnchor, constant: 0),
            selectedImageView.widthAnchor.constraint(equalToConstant: (3/4)*frame.width),
            selectedImageView.heightAnchor.constraint(equalToConstant: (3/4)*frame.width),
            selectedImageView.centerXAnchor.constraint(equalTo: selectedImageContainerView.centerXAnchor),
            selectedImageView.bottomAnchor.constraint(equalTo: selectedImageContainerView.bottomAnchor, constant: 0),
            
//            leftNavigator.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
//            leftNavigator.widthAnchor.constraint(equalToConstant: (1/8)*frame.width),
//            leftNavigator.heightAnchor.constraint(equalToConstant: (1/8)*frame.width),
//            leftNavigator.centerXAnchor.constraint(equalTo: selectedImageContainerView.centerXAnchor),
//
//            rightNavigator.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
//            rightNavigator.widthAnchor.constraint(equalToConstant: (1/8)*frame.width),
//            rightNavigator.heightAnchor.constraint(equalToConstant: (1/8)*frame.width),
//            rightNavigator.centerYAnchor.constraint(equalTo: selectedImageContainerView.centerYAnchor),
            
            sendButton.topAnchor.constraint(equalTo: sendButttonContainerView.topAnchor, constant: 0),
            sendButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.centerXAnchor.constraint(equalTo: sendButttonContainerView.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: sendButttonContainerView.bottomAnchor, constant: -Constant.contentPadding),
            
//            leftNavigator.widthAnchor.constraint(equalToConstant: 80),
//            leftNavigator.heightAnchor.constraint(equalToConstant: 80),
//
//            rightNavigator.widthAnchor.constraint(equalToConstant: 80),
//            rightNavigator.heightAnchor.constraint(equalToConstant: 80),
//
//            thumbnailPostcordImage.widthAnchor.constraint(equalToConstant: 80),
//            thumbnailPostcordImage.heightAnchor.constraint(equalToConstant: 80)
//            roverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            roverImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -(1/10)*frame.width),
//            roverImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -(1/10)*frame.width),
//            roverImageView.widthAnchor.constraint(equalToConstant: (3/5)*frame.width),
//            roverImageView.heightAnchor.constraint(equalToConstant: (3/5)*frame.width),
//
//            stampImageView.topAnchor.constraint(equalTo: roverImageView.topAnchor, constant: 15),
//            stampImageView.trailingAnchor.constraint(equalTo: roverImageView.trailingAnchor, constant: -15),
//            stampImageView.widthAnchor.constraint(equalToConstant: 60),
//            stampImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc private func sendPostcard(tapGestureRecognizer: UITapGestureRecognizer) {
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

class StackViewCell: UIView {
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

    }

}
