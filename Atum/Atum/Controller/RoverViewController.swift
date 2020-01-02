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
    lazy var currentDate: String = getCurrentDate() // Cou
    
    private func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
//    private func getLandingData() -> String {
//        var components = DateComponents()
//        components.month = 08
//        components.day = 06
//        components.year = 2012
//    }
    
    let rovers: [Rover] = [Rover.curiosity]
    let cameras: [RoverCamera] = [RoverCamera.fhaz, RoverCamera.rhaz, RoverCamera.mast, RoverCamera.chemcam, RoverCamera.mahli, RoverCamera.mardi, RoverCamera.navcam]
    var selectedCamera: Int = 0
    
    var photos: [Photo] = [Photo]()
    
    var retrievedImages: [UIImage] = [UIImage]()

    // Selected Image
    lazy var selectedImageView: RetrievedImageView = {
        let image = UIImage(named: .placeholderImage)
        let selectedImageView = RetrievedImageView(image: image)
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
    
    lazy var cameraSelectionButton: CustomButton = {
        let cameraSelectionButton = CustomButton(type: .custom)
        cameraSelectionButton.setTitle("\(cameras[selectedCamera].fullName)", for: .normal)
        cameraSelectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        cameraSelectionButton.addTarget(self, action: #selector(switchCamera(tapGestureRecognizer:)), for: .touchUpInside)
        return cameraSelectionButton
    }()
    
    // Curiosity Landing Date: "2012-08-06" yyyy-MM-dd
    lazy var roverDatePicker: UIDatePicker = {
        let roverDatePicker = UIDatePicker()
        roverDatePicker.backgroundColor = UIColor.clear
        roverDatePicker.setValue(UIColor(named: .textTintColor), forKey: "textColor")
        roverDatePicker.calendar = .current
        roverDatePicker.datePickerMode = .date
        roverDatePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.month = 08
        components.day = 06
        components.year = 2012
        let startDate = calendar.date(from: components)
        roverDatePicker.minimumDate = startDate
        let currentDate = Date()
        roverDatePicker.maximumDate = currentDate
        roverDatePicker.timeZone = NSTimeZone.local
        roverDatePicker.translatesAutoresizingMaskIntoConstraints = false
        roverDatePicker.date = startDate!
        return roverDatePicker
    }()
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: datePicker.date)
        print(dateString)
        dateInfoField.text = dateString
        UserSelection.userRoverDataSelections.selectedRoverPhotoDate = dateString
        getRoverPhotos()
    }
    
    lazy var sendButton: CustomButton = {
        let sendButton = CustomButton(type: .custom)
        let image = UIImage(named: .sendIcon)?.withRenderingMode(.alwaysTemplate)
        let inset: CGFloat = Constant.sendButtonIconInset
        sendButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        sendButton.setImage(image, for: .normal)
        sendButton.addTarget(self, action: #selector(sendPostcard(tapGestureRecognizer:)), for: .touchUpInside)
        return sendButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
        setupView()
        getRoverPhotos()
    }
    
    private func getRoverPhotos() {
        RoverPhotoDataManager.fetchPhotos(date: UserSelection.userRoverDataSelections.selectedRoverPhotoDate, camera: UserSelection.userRoverDataSelections.selectedRoverCamera.abbreviation) { (photos, error) in
            DispatchQueue.main.async {
                guard let photos = photos else {
                    self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                    return
                }
                self.photos = photos
                print(self.photos)
            }
        }
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
        
        view.addSubview(cameraSelectionButton)
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
            
            // Buttons and Picker
            cameraSelectionButton.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            cameraSelectionButton.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            cameraSelectionButton.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            cameraSelectionButton.heightAnchor.constraint(equalToConstant: Constant.cameraButtonHeigth),

            roverDatePicker.topAnchor.constraint(equalTo: cameraSelectionButton.bottomAnchor, constant: Constant.contentPadding),
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
        getRoverPhotos()
        print("Sending Email")
    }
    
    @objc private func switchCamera(tapGestureRecognizer: UITapGestureRecognizer) {
        if selectedCamera != cameras.count - 1 {
            selectedCamera += 1
        } else {
            selectedCamera = 0
        }
        cameraSelectionButton.setTitle("\(cameras[selectedCamera].fullName)", for: .normal)
        cameraInfoField.text = "\(cameras[selectedCamera].abbreviation)"
        UserSelection.userRoverDataSelections.selectedRoverCamera = cameras[selectedCamera] // MARK: User Selection
        getRoverPhotos()
        print("Switching Camera")
    }
    
    @objc private func showPreviousSuggestion() {
        print("Showing Previous Image")
    }
    
    @objc private func showNextSuggestion() {
        print("Showing Next Image")
    }
    
}
