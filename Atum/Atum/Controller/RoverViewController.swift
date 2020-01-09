//
//  RoverViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RoverViewController: UIViewController {
    
    lazy var currentDate: String = getCurrentDate()
    let emailManagerSlider = EmailManagerSlider()
    let rovers: [Rover] = [Rover.curiosity]
    
    let cameras: [RoverCamera] = [RoverCamera.fhaz, RoverCamera.rhaz, RoverCamera.mast, RoverCamera.chemcam, RoverCamera.mahli, RoverCamera.mardi, RoverCamera.navcam]
    var selectedCamera: Int = 0
    
    var photos: [RoverPhoto] = [RoverPhoto]()
    var selectedPhoto: Int = 0
    
    lazy var selectedImageView: RetrievedImageView = {
        let image = UIImage(named: .placeholderImage)
        let selectedImageView = RetrievedImageView(image: image)
        return selectedImageView
    }()
    
    lazy var leftNavigator: LeftNavigator = {
        let navigator = LeftNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPreviousPhoto))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
    
    lazy var rightNavigator: RightNavigator = {
        let navigator = RightNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNextPhoto))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
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
        dateInfoField.text = "\(MarsRoverQueryData.userRoverDataSelections.selectedRoverPhotoDate)"
        return dateInfoField
    }()
    
    lazy var photoCountInfoField: PhotoCountInfoField = {
        let photoCountInfoField = PhotoCountInfoField()
        photoCountInfoField.text = "\(selectedPhoto) / \(photos.count)"
        return photoCountInfoField
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
        if let landingDate = calendar.date(from: components) {
            roverDatePicker.minimumDate = landingDate
        }
        components.month = 08
        components.day = 06
        components.year = 2015
        if let defaultDate = calendar.date(from: components) {
            roverDatePicker.setDate(defaultDate, animated: true)
        }
        let currentDate = Date()
        roverDatePicker.maximumDate = currentDate
        roverDatePicker.timeZone = NSTimeZone.local
        roverDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return roverDatePicker
    }()
    
    lazy var launchSliderMenuButton: CustomButton = {
        let launchSliderMenuButton = CustomButton(type: .custom)
        let image = UIImage(named: .sendIcon)?.withRenderingMode(.alwaysTemplate)
        let inset: CGFloat = Constant.sendButtonIconInset
        launchSliderMenuButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        launchSliderMenuButton.setImage(image, for: .normal)
        launchSliderMenuButton.addTarget(self, action: #selector(presentMenuSlider(tapGestureRecognizer:)), for: .touchUpInside)
        return launchSliderMenuButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
        setupView()
        getRoverPhotos()
    }
    
    private func setupView() {
        view.addSubview(leftNavigator)
        view.addSubview(rightNavigator)
        view.addSubview(selectedImageView)
        view.addSubview(photoCountInfoField)
        
        view.addSubview(roverInfoField)
        view.addSubview(cameraInfoField)
        view.addSubview(dateInfoField)
        
        view.addSubview(cameraSelectionButton)
        view.addSubview(roverDatePicker)
        view.addSubview(launchSliderMenuButton)
        
        let viewWidth: CGFloat = view.frame.width
        let selectedImageSize: CGFloat = (3/4)*view.frame.width
        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        
        NSLayoutConstraint.activate([
            // Current Selection
            selectedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.contentPadding),
            selectedImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leftNavigator.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -Constant.photoNavigatorOffset),
            leftNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            leftNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            leftNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            rightNavigator.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: Constant.photoNavigatorOffset),
            rightNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            rightNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            rightNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            photoCountInfoField.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            photoCountInfoField.widthAnchor.constraint(equalToConstant: Constant.photoCountWidth),
            photoCountInfoField.heightAnchor.constraint(equalToConstant: Constant.photoCountHeigth),
            photoCountInfoField.centerYAnchor.constraint(equalTo: selectedImageView.bottomAnchor),
            
            // Photo data
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
            dateInfoField.bottomAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: -Constant.bottomTextFieldPadding),
            
            // Buttons and Picker
            cameraSelectionButton.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            cameraSelectionButton.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            cameraSelectionButton.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            cameraSelectionButton.heightAnchor.constraint(equalToConstant: Constant.wideButtonHeigth),

            roverDatePicker.topAnchor.constraint(equalTo: cameraSelectionButton.bottomAnchor, constant: Constant.contentPadding),
            roverDatePicker.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            roverDatePicker.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            roverDatePicker.bottomAnchor.constraint(equalTo: launchSliderMenuButton.topAnchor, constant: -Constant.contentPadding),
            
            launchSliderMenuButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            launchSliderMenuButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            launchSliderMenuButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            launchSliderMenuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
        ])
    }
    
    private func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    private func getRoverPhotos() {
        selectedPhoto = 0 // Each API call we reset selectedPhoto
        let connectionPossible = Reachability.checkReachable()
        if connectionPossible == true {
            MarsRoverDataManager.getPhotos(date: MarsRoverQueryData.userRoverDataSelections.selectedRoverPhotoDate, camera: MarsRoverQueryData.userRoverDataSelections.selectedRoverCamera.abbreviation) { (photos, error) in
                DispatchQueue.main.async {
                    guard let photos = photos else {
                        self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                        return
                    }
                    self.photos = photos
                    self.updateUI()
                    //                print(self.photos) //
                }
            }
        } else {
            selectedImageView.image = UIImage(named: .placeholderImage)
            self.presentAlert(description: NetworkingError.noReachability.localizedDescription, viewController: self)
        }
    }
    
    private func updateUI() {
        if photos.count != 0 {
            setRetrievedImage()
        } else {
            selectedImageView.image = UIImage(named: .placeholderImage)?.croppedToSquare(size: Constant.croppedSquareSize)
        }
        updatePhotoCounter()
    }
    
    private func updatePhotoCounter() {
        if photos.count != 0 {
            photoCountInfoField.text = "\(selectedPhoto + 1) / \(photos.count)"
        } else {
            photoCountInfoField.text = "\(selectedPhoto) / \(photos.count)"
        }
    }
    
    private func setRetrievedImage() {
        DispatchQueue.main.async {
            let connectionPossible = Reachability.checkReachable()
            if connectionPossible == true {
                self.selectedImageView.fetchPhoto(from: self.photos[self.selectedPhoto].imgSrc)
            } else {
                self.presentAlert(description: NetworkingError.noReachability.localizedDescription, viewController: self)
            }
        }
    }
    
    @objc private func showPreviousPhoto(sender: LeftNavigator) {
        if photos.count != 0 {
            if selectedPhoto == 0 {
                selectedPhoto = photos.count - 1
            } else {
                selectedPhoto -= 1
            }
            selectedImageView.fetchPhoto(from: photos[selectedPhoto].imgSrc)
        }
        updatePhotoCounter()
    }
    
    @objc private func showNextPhoto(sender: RightNavigator) {
        if photos.count != 0 {
            if selectedPhoto != photos.count - 1 {
                selectedPhoto += 1
            } else {
                selectedPhoto = 0
            }
            selectedImageView.fetchPhoto(from: photos[selectedPhoto].imgSrc)
        }
        updatePhotoCounter()
    }
    
    @objc private func switchCamera(tapGestureRecognizer: UITapGestureRecognizer) {
        if selectedCamera != cameras.count - 1 {
            selectedCamera += 1
        } else {
            selectedCamera = 0
        }
        cameraSelectionButton.setTitle("\(cameras[selectedCamera].fullName)", for: .normal)
        cameraInfoField.text = "\(cameras[selectedCamera].abbreviation)"
        MarsRoverQueryData.userRoverDataSelections.selectedRoverCamera = cameras[selectedCamera] // MARK: User Selection
        getRoverPhotos()
        print("Switching Camera")
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: datePicker.date)
        print(dateString)
        dateInfoField.text = dateString
        MarsRoverQueryData.userRoverDataSelections.selectedRoverPhotoDate = dateString
        getRoverPhotos()
    }
    
    @objc private func presentMenuSlider(tapGestureRecognizer: UITapGestureRecognizer) {
        if selectedImageView.image == UIImage(named: .placeholderImage) {
            presentAlert(description: NetworkingError.noImage.localizedDescription, viewController: self)
        } else {
            emailManagerSlider.selectedImageView.image = self.selectedImageView.image
            emailManagerSlider.roverInfoField.text = self.roverInfoField.text
            emailManagerSlider.cameraInfoField.text = self.cameraInfoField.text
            emailManagerSlider.dateInfoField.text = self.dateInfoField.text
            emailManagerSlider.modeSelected = .marsRoverMode
            emailManagerSlider.presentSlider()
        }
    }
}
