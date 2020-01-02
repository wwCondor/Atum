//
//  RoverViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RoverViewController: UIViewController {
    
    // used to set one of the limits for the datePicker
    lazy var currentDate: String = getCurrentDate()
    
    private func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    let rovers: [Rover] = [Rover.curiosity]
    let cameras: [RoverCamera] = [RoverCamera.fhaz, RoverCamera.rhaz, RoverCamera.mast, RoverCamera.chemcam, RoverCamera.mahli, RoverCamera.mardi, RoverCamera.navcam]
    var selectedCamera: Int = 0
    
    var photos: [Photo] = [Photo]()
    
    func fetchPhotoData() {
        print("Fetching photo data")
    }

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
    lazy var greetingTextField: PostcardGreetingField = {
        let greetingTextField = PostcardGreetingField()
        greetingTextField.text = "Greetings from Mars!"
        return greetingTextField
    }()
    
    lazy var roverInfoField: PostcardImageInfoField = {
        let roverInfoField = PostcardImageInfoField()
        roverInfoField.text = "\(Rover.curiosity.name)"
        return roverInfoField
    }()
    
    lazy var cameraInfoField: PostcardImageInfoField = {
        let cameraInfoField = PostcardImageInfoField()
        cameraInfoField.text = "\(cameras[selectedCamera].abbreviation)"
        return cameraInfoField
    }()
    
    lazy var dateInfoField: PostcardImageInfoField = {
        let dateInfoField = PostcardImageInfoField()
        dateInfoField.text = "\(currentDate)"
        return dateInfoField
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
    
    lazy var cameraButton: CustomButton = {
        let cameraButton = CustomButton(type: .custom)
        cameraButton.setTitle("\(cameras[selectedCamera].fullName)", for: .normal)
        cameraButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        cameraButton.addTarget(self, action: #selector(switchCamera(tapGestureRecognizer:)), for: .touchUpInside)
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.cornerRadius = Constant.smallCornerRadius
        cameraButton.layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        cameraButton.layer.borderWidth = Constant.sendButtonBorderWidth
        return cameraButton
    }()
    
    lazy var roverDatePicker: UIDatePicker = {
        let roverDatePicker = UIDatePicker()
        roverDatePicker.backgroundColor = UIColor.clear
        roverDatePicker.setValue(UIColor(named: .textTintColor), forKey: "textColor")
        roverDatePicker.calendar = .current
        roverDatePicker.datePickerMode = .date
        roverDatePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = 100
        let maxDate = calendar.date(byAdding: components, to: Date())
        components.year = -100
        let minDate = calendar.date(byAdding: components, to: Date())
        roverDatePicker.minimumDate = minDate
        roverDatePicker.maximumDate = maxDate
        roverDatePicker.timeZone = NSTimeZone.local
        roverDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return roverDatePicker
    }()
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        print(dateFormatter.string(from: datePicker.date))
        dateInfoField.text = dateFormatter.string(from: datePicker.date)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
        setupView()
    }
    
    func setupView() {
        // selectedImageContainerView content
        view.addSubview(leftNavigator)
        view.addSubview(selectedImageView)
        view.addSubview(rightNavigator)
        
        // Meta Data TextFields
        view.addSubview(greetingTextField)
        view.addSubview(roverInfoField)
        view.addSubview(cameraInfoField)
        view.addSubview(dateInfoField)
        
        view.addSubview(cameraButton)
        view.addSubview(roverDatePicker)
        view.addSubview(sendButton)
        
        let viewWidth: CGFloat = view.frame.width
        let selectedImageSize: CGFloat = (3/4)*view.frame.width
        let contentSidePadding = (viewWidth - selectedImageSize) / 2
        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        let navigatorOffset: CGFloat = 2
        
        NSLayoutConstraint.activate([
            // Current Selection
            selectedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.contentPadding),
            selectedImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leftNavigator.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -navigatorOffset),
            leftNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            leftNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            leftNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            rightNavigator.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: navigatorOffset),
            rightNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            rightNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            rightNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            // Postcard metadata
            greetingTextField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.contentSidePadding),
            greetingTextField.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: -Constant.contentSidePadding),
            greetingTextField.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            greetingTextField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
            
            roverInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.textFieldPadding),
            roverInfoField.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            roverInfoField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
            roverInfoField.bottomAnchor.constraint(equalTo: cameraInfoField.topAnchor),
            
            cameraInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.textFieldPadding),
            cameraInfoField.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            cameraInfoField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
            cameraInfoField.bottomAnchor.constraint(equalTo: dateInfoField.topAnchor),
            
            dateInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.textFieldPadding),
            dateInfoField.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            dateInfoField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
            dateInfoField.bottomAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: -Constant.textFieldPadding),
            //
            
            cameraButton.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            cameraButton.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            cameraButton.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            cameraButton.heightAnchor.constraint(equalToConstant: Constant.cameraButtonHeigth),

            roverDatePicker.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: Constant.contentPadding),
            roverDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentSidePadding),
            roverDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -contentSidePadding),
            roverDatePicker.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -Constant.contentPadding),
            
            sendButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
        ])
    }
    
    @objc private func sendPostcard(tapGestureRecognizer: UITapGestureRecognizer) {
        fetchPhotoData()
        print("Sending Email")
    }
    
    @objc private func switchCamera(tapGestureRecognizer: UITapGestureRecognizer) {
        if selectedCamera != cameras.count - 1 {
            selectedCamera += 1
        } else {
            selectedCamera = 0
        }
        cameraButton.setTitle("\(cameras[selectedCamera].fullName)", for: .normal)
        cameraInfoField.text = "\(cameras[selectedCamera].abbreviation)"
        
        print("Switching Camera")
    }
    
    @objc private func showPreviousSuggestion() {
        print("Showing Previous Image")
    }
    
    @objc private func showNextSuggestion() {
        print("Showing Next Image")
    }
    
}
