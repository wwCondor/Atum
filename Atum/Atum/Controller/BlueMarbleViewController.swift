//
//  BlueMarbleViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class BlueMarbleViewController: UIViewController {
    
    let sliderMenuManager = SliderMenuManager()
    
    var allNaturalDates: [BlueMarbleDate] = [BlueMarbleDate]()
    var retrievedPhotos: [BlueMarblePhoto] = [BlueMarblePhoto]()
//    var imagesForDate: [UIImage] = [UIImage]() // Not used yet
    var selectedPhoto: Int = 0
    
    // Selected Image
    lazy var selectedImageView: RetrievedImageView = {
        let image = UIImage(named: .placeholderImage)
        let selectedImageView = RetrievedImageView(image: image)
        return selectedImageView
    }()
    
    lazy var leftNavigator: LeftNavigator = {
        let navigator = LeftNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPreviousPhoto(sender:)))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
    
    lazy var rightNavigator: RightNavigator = {
        let navigator = RightNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNextPhoto(sender:)))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
    
    lazy var timeInfoField: PostcardImageInfoField = {
        let timeInfoField = PostcardImageInfoField()
        timeInfoField.text = "00:00:00"//"\(cameras[selectedCamera].abbreviation)"
        return timeInfoField
    }()
    
    lazy var photoCountInfoField: PhotoCountInfoField = {
        let photoCountInfoField = PhotoCountInfoField()
        photoCountInfoField.text = "\(selectedPhoto) / \(retrievedPhotos.count)"
        return photoCountInfoField
    }()
    
    lazy var naturalDatePicker: UIPickerView = {
        let naturalDatePicker = UIPickerView()
        naturalDatePicker.translatesAutoresizingMaskIntoConstraints = false
        naturalDatePicker.backgroundColor = UIColor.clear
        naturalDatePicker.delegate = self
        naturalDatePicker.dataSource = self
        return naturalDatePicker
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
        getNaturalDates()
    }
    
    private func setupView() {
        view.addSubview(selectedImageView)
        view.addSubview(leftNavigator)
        view.addSubview(rightNavigator)
        view.addSubview(photoCountInfoField)
        
        view.addSubview(timeInfoField)

        view.addSubview(naturalDatePicker)
        view.addSubview(launchSliderMenuButton)
        
        let viewWidth: CGFloat = view.frame.width
        let selectedImageSize: CGFloat = (3/4)*view.frame.width
        
        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        
        NSLayoutConstraint.activate([
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
            
            // Photo Data
            timeInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.textFieldPadding),
            timeInfoField.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            timeInfoField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
            timeInfoField.bottomAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: -2*Constant.textFieldPadding),
            
            naturalDatePicker.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            naturalDatePicker.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            naturalDatePicker.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            naturalDatePicker.bottomAnchor.constraint(equalTo: launchSliderMenuButton.topAnchor, constant: -Constant.contentPadding),
            
            launchSliderMenuButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            launchSliderMenuButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            launchSliderMenuButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            launchSliderMenuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
        ])
    }
    
    private func getNaturalDates() {
        let connetionPossible = Reachability.checkReachable()
        if connetionPossible == true {
            BlueMarbleDataManager.fetchDates { (data, error) in
                DispatchQueue.main.async {
                    guard let dates = data else {
                        self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                        return
                    }
                    for date in dates {
                        self.allNaturalDates.append(date)
                    }
                    print("Dates with images: \(self.allNaturalDates.count)")
                    self.naturalDatePicker.reloadAllComponents()
                    self.getPhotosForDate(date: self.allNaturalDates[0].date
                    )
                }
            }
        } else {
            self.presentAlert(description: NetworkingError.noReachability.localizedDescription, viewController: self)
        }
    }
    
    private func updatePhotoCounter() {
        photoCountInfoField.text = "\(selectedPhoto + 1) / \(retrievedPhotos.count)"
    }
    
    private func getPhotosForDate(date: String) {
        selectedPhoto = 0
        let connetionPossible = Reachability.checkReachable()
        if connetionPossible == true {
            retrievedPhotos.removeAll() // Make sure array is empty
            BlueMarbleDataManager.fetchPhotos(date: date) { (data, error) in
                DispatchQueue.main.async {
                    guard let photos = data else {
                        self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                        return
                    }
                    for photo in photos {
                        self.retrievedPhotos.append(photo)
                    }
                    print("Photo Data retrieved from API: \(self.retrievedPhotos)")
                    self.updatePhotoCounter()
                    self.updateTimeInfoField()
                    self.selectedImageView.fetchPhoto(date: BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate, imageName: self.retrievedPhotos[self.selectedPhoto].image)
                }
            }
        } else {
            selectedImageView.image = UIImage(named: .placeholderImage)
            self.presentAlert(description: NetworkingError.noReachability.localizedDescription, viewController: self)
        }
    }
    
    @objc private func presentMenuSlider(tapGestureRecognizer: UITapGestureRecognizer) {
        if selectedImageView.image == UIImage(named: .placeholderImage) {
            presentAlert(description: NetworkingError.noImage.localizedDescription, viewController: self)
        } else {
            sliderMenuManager.selectedImageView.image = self.selectedImageView.image
            sliderMenuManager.greetingTextField.text = PlaceHolderText.postcardDefaultMessage
            sliderMenuManager.roverInfoField.text = ""
            sliderMenuManager.cameraInfoField.text = ""
            sliderMenuManager.dateInfoField.text = BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate
            sliderMenuManager.modeSelected = .blueMarbleMode
            sliderMenuManager.presentSlider()
            print("Presenting Slider Menu")
        }
    }
    
    private func updateTimeInfoField() {
        let fullDate: String = retrievedPhotos[selectedPhoto].date
        let fullDateArray: [String] = fullDate.components(separatedBy: " ")
        let timeStamp: String = fullDateArray[1]
        timeInfoField.text = "\(timeStamp)"
    }
    
    @objc private func showPreviousPhoto(sender: LeftNavigator) {
        if retrievedPhotos.count != 0 {
            if selectedPhoto == 0 {
                selectedPhoto = retrievedPhotos.count - 1
            } else {
                selectedPhoto -= 1
            }
            selectedImageView.fetchPhoto(date: BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate, imageName: retrievedPhotos[selectedPhoto].image)
        }
        updatePhotoCounter()
        updateTimeInfoField()
    }
    
    @objc private func showNextPhoto(sender: RightNavigator) {
        if retrievedPhotos.count != 0 {
            if selectedPhoto != retrievedPhotos.count - 1 {
                selectedPhoto += 1
            } else {
                selectedPhoto = 0
            }
            selectedImageView.fetchPhoto(date: BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate, imageName: retrievedPhotos[selectedPhoto].image)
        }
        updatePhotoCounter()
        updateTimeInfoField()
    }
}

extension BlueMarbleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if allNaturalDates.count == 0 {
            return 1
        } else {
            return allNaturalDates.count
        }
    }
    
    // Data being returned for each column
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if allNaturalDates.count == 0 {
            return "Retreiving dates..."
        } else {
            return allNaturalDates[row].date
        }
    }
    
    // Action after selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Date selected: \(allNaturalDates[row].date)")
        BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate = allNaturalDates[row].date
        print("Querydate stored: \(BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate)")
        getPhotosForDate(date: allNaturalDates[row].date)
    }
    
    // MARK: Picker Customization
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
            label.text = "Retreiving dates..."
        } else {
            label.text = allNaturalDates[row].date
        }
        return label
    }
}
