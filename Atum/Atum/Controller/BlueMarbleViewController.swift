//
//  BlueMarbleViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class BlueMarbleViewController: UIViewController {
    
    var allNaturalDates: [BlueMarbleDate] = [BlueMarbleDate]()
    var retrievedPhotos: [BlueMarblePhoto] = [BlueMarblePhoto]()
    var selectedPhoto: Int = 0
    
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
        startPuzzleButton.addTarget(self, action: #selector(presentMarblePuzzle(tapGestureRecognizer:)), for: .touchUpInside)
        return startPuzzleButton
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
        view.addSubview(startPuzzleButton)
        view.addSubview(naturalDatePicker)
        
        let viewWidth: CGFloat = view.frame.width
        let selectedImageSize: CGFloat = (3/4)*view.frame.width
        
        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        
        NSLayoutConstraint.activate([
            // Current Selection
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
            
            startPuzzleButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            startPuzzleButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            startPuzzleButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            startPuzzleButton.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            
            naturalDatePicker.topAnchor.constraint(equalTo: startPuzzleButton.bottomAnchor, constant: Constant.contentPadding),
            naturalDatePicker.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            naturalDatePicker.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            naturalDatePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
        ])
    }
    
    private func getNaturalDates() {
        BlueMarbleDataManager.fetchDates { (data, error) in
            DispatchQueue.main.async {
                guard let dates = data else {
                    self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                    return
                }
                for date in dates {
                    self.allNaturalDates.append(date)
                }
                print(self.allNaturalDates.count)
                self.naturalDatePicker.reloadAllComponents()
            }
        }
    }
    
    private func getPhotoForDate(date: String) {
        BlueMarbleDataManager.fetchPhotos(date: date) { (data, error) in
            DispatchQueue.main.async {
                guard let photos = data else {
                    self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                    return
                }
                for photo in photos {
                    self.retrievedPhotos.append(photo)
                }
                print(self.retrievedPhotos)
            }
        }
    }
    
    @objc private func presentMarblePuzzle(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Sending Email")
    }
    
    @objc private func showPreviousSuggestion() {
        print("Showing Previous Image")
    }
    
    @objc private func showNextSuggestion() {
        print("Showing Next Image")
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
        getPhotoForDate(date: allNaturalDates[row].date)
//
//        if allNaturalDates.count == 0 {
//            greetingTextField.text = "Retreiving dates..."
//        } else {
//            greetingTextField.text = allNaturalDates[row].date
//            getPhotoForDate()
//        }
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
