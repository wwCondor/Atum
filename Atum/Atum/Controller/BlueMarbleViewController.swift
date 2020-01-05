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
    var imagesForDate: [UIImage] = [UIImage]() // Not used yet
    var selectedPhoto: Int = 0
    
    // Selected Image
    lazy var leftNavigator: LeftNavigator = {
        let navigator = LeftNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPreviousPhoto(sender:)))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
    
    lazy var selectedImageView: RetrievedImageView = {
        let image = UIImage(named: .placeholderImage)
        let selectedImageView = RetrievedImageView(image: image)
        return selectedImageView
    }()
    
    lazy var rightNavigator: RightNavigator = {
        let navigator = RightNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNextPhoto(sender:)))
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
    
    lazy var sendButton: CustomButton = {
        let sendButton = CustomButton(type: .custom)
        let image = UIImage(named: .sendIcon)?.withRenderingMode(.alwaysTemplate)
        let inset: CGFloat = Constant.sendButtonIconInset
        sendButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        sendButton.setImage(image, for: .normal)
        sendButton.addTarget(self, action: #selector(presentMenuSlider(tapGestureRecognizer:)), for: .touchUpInside)
        return sendButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
        setupView()
        getNaturalDates()
    }
    
    private func setupView() {
        view.addSubview(leftNavigator)
        view.addSubview(selectedImageView)
        view.addSubview(rightNavigator)
        view.addSubview(sendButton)
        view.addSubview(naturalDatePicker)
        
        let viewWidth: CGFloat = view.frame.width
        let selectedImageSize: CGFloat = (3/4)*view.frame.width
        
        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        
        NSLayoutConstraint.activate([
            leftNavigator.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -Constant.photoNavigatorOffset),
            leftNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            leftNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            leftNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            selectedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.contentPadding),
            selectedImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rightNavigator.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: Constant.photoNavigatorOffset),
            rightNavigator.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
            rightNavigator.widthAnchor.constraint(equalToConstant: navigatorWidth),
            rightNavigator.heightAnchor.constraint(equalToConstant: navigatorHeigth),
            
            naturalDatePicker.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            naturalDatePicker.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            naturalDatePicker.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            naturalDatePicker.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -Constant.contentPadding),
            
            // Not used atm
            sendButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
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
    
    @objc private func showPreviousPhoto(sender: LeftNavigator) {
        if retrievedPhotos.count != 0 {
            if selectedPhoto == 0 {
                selectedPhoto = retrievedPhotos.count - 1
            } else {
                selectedPhoto -= 1
            }
            selectedImageView.fetchPhoto(date: BlueMarbleQueryData.userBlueMarbleDataSelection.selectedDate, imageName: retrievedPhotos[selectedPhoto].image)
        }
        print("Showing Previous Image: \(selectedPhoto)/\(retrievedPhotos.count)")
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
        print("Showing Next Image: \(selectedPhoto)/\(retrievedPhotos.count)")
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
