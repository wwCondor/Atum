//
//  MarsRoverCell.swift
//  Atum
//
//  Created by Wouter Willebrands on 28/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MarsRoverCell: BaseCell {

    // Maybe store this in struct somewhere
    let selectedRover: Rover = .curiosity
//    var selectedCamera: RoverCamera = .navcam
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
//        for rover in rovers {
//            RoverPhotoDataManager.fetchPhotos(rover: rover.name, sol: Int.random(in: 1...2000), camera: selectedCamera.abbreviation) { (photos, error) in
//                DispatchQueue.main.async {
//                    guard let photos = photos else {
//                        print("No photos")
//                        //                        print(error?.localizedDescription)
//                        return
//                    }
//                    self.photos = photos
//                    print(photos)
//                }
//            }
//        }
    }

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
    lazy var greetingTextField: PostcardGreetingField = {
        let greetingTextField = PostcardGreetingField()
        greetingTextField.text = "Greetings from Mars!"
        return greetingTextField
    }()
    
    lazy var roverInfoField: PostcardImageInfoField = {
        let roverInfoField = PostcardImageInfoField()
        roverInfoField.text = "\(selectedRover.name)"
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
    
//    lazy var stampImageView: UIImageView = {
//        let stampImageView = UIImageView()
//        stampImageView.translatesAutoresizingMaskIntoConstraints = false
//        stampImageView.backgroundColor = UIColor.blue
//        return stampImageView
//    }()
    
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
    
//    lazy var roverAndCameraPicker: UIPickerView = {
//        let roverAndCameraPicker = UIPickerView()
//        roverAndCameraPicker.translatesAutoresizingMaskIntoConstraints = false
//        roverAndCameraPicker.backgroundColor = UIColor.clear
//        roverAndCameraPicker.delegate = self
//        roverAndCameraPicker.dataSource = self
//        return roverAndCameraPicker
//    }()
    
//    lazy var leftCamNavigator: LeftNavigator = {
//        let leftCamNavigator = LeftNavigator()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPreviousSuggestion))
//        leftCamNavigator.addGestureRecognizer(tapGesture)
//        return leftCamNavigator
//    }()
    
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
    
//    lazy var rightCamNavigator: RightNavigator = {
//        let rightCamNavigator = RightNavigator()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNextSuggestion))
//        rightCamNavigator.addGestureRecognizer(tapGesture)
//        return rightCamNavigator
//    }()
    
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
//        selectedDate = dateFormatter.string(from: datePicker.date)
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

    override func setupView() {
//        createSolArrays()
        addSubview(cellContentView)
        
        // selectedImageContainerView content
        cellContentView.addSubview(leftNavigator)
        cellContentView.addSubview(selectedImageView)
        cellContentView.addSubview(rightNavigator)
        
//        cellContentView.addSubview(leftCamNavigator)
        cellContentView.addSubview(cameraButton)
//        cellContentView.addSubview(rightCamNavigator)
        
        // Meta Data TextFields
        cellContentView.addSubview(greetingTextField)
        cellContentView.addSubview(roverInfoField)
        cellContentView.addSubview(cameraInfoField)
        cellContentView.addSubview(dateInfoField)
        
//        cellContentView.addSubview(roverAndCameraPicker)
        cellContentView.addSubview(roverDatePicker)
        cellContentView.addSubview(sendButton)
        
        let viewWidth: CGFloat = frame.width
        let selectedImageSize: CGFloat = (3/4)*frame.width
        let contentSidePadding = (viewWidth - selectedImageSize) / 2
        let navigatorWidth = (viewWidth - selectedImageSize) / 2
        let navigatorHeigth = navigatorWidth * 2
        let navigatorOffset: CGFloat = 2
        
//        let camNavigatorHeigth = Constant.sendButtonSize
//        let camNavigatorWidth = camNavigatorHeigth / 2
        
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
            
            // camera button
            
//            leftCamNavigator.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -Constant.contentPadding),
//            leftCamNavigator.centerYAnchor.constraint(equalTo: cameraButton.centerYAnchor),
//            leftCamNavigator.widthAnchor.constraint(equalToConstant: camNavigatorWidth),
//            leftCamNavigator.heightAnchor.constraint(equalToConstant: camNavigatorHeigth),

            cameraButton.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            cameraButton.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
            cameraButton.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            cameraButton.heightAnchor.constraint(equalToConstant: Constant.cameraButtonHeigth),
//            cameraButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            
//            rightCamNavigator.leadingAnchor.constraint(equalTo: cameraButton.trailingAnchor, constant: Constant.contentPadding),
//            rightCamNavigator.centerYAnchor.constraint(equalTo: cameraButton.centerYAnchor),
//            rightCamNavigator.widthAnchor.constraint(equalToConstant: camNavigatorWidth),
//            rightCamNavigator.heightAnchor.constraint(equalToConstant: camNavigatorHeigth),
            
//            roverAndCameraPicker.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
//            roverAndCameraPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.contentSidePadding),
//            roverAndCameraPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.contentSidePadding),
//            roverAndCameraPicker.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -Constant.contentPadding),
            
            roverDatePicker.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: Constant.contentPadding),
            roverDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentSidePadding),
            roverDatePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentSidePadding),
            roverDatePicker.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -Constant.contentPadding),

            sendButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            sendButton.centerXAnchor.constraint(equalTo: selectedImageView.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -Constant.contentPadding),
        ])
    }
    
    @objc private func sendPostcard(tapGestureRecognizer: UITapGestureRecognizer) {
        fetchPhotoData()
//        if sendButton.isHighlighted == true {
//            sendButton.tintColor = UIColor(named: .iconSelectedColor)
//        } else {
//            sendButton.tintColor = UIColor(named: .iconColor)
//        }

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

// MARK: Picker
//extension MarsRoverCell: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    // We have 3 search input parameters for the users: Rover, Camera and Sol
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 3
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch component {
//        case 0: return rovers.count
//        case 1: return cameras.count
//        case 2: return 1
//        default: return 1
//        }
//    }
//
////     Data being returned for each column
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch component {
//        case 0: return rovers[row].name
//        case 1: return cameras[row].abbreviation
//        case 2: return "1"
//        default:
//            return "x"
//        }
//    }
//
//    // This part updates the selected categories
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch component {
//        case 0:
//            selectedRover = rovers[row]
//            roverInfoField.text = rovers[row].name
//            print(selectedRover)
//        case 1:
//            selectedCamera = cameras[row]
//            cameraInfoField.text = cameras[row].abbreviation
//            print(selectedCamera)
//        default: selectedCamera = cameras[row]
//        }
//    }
//
////     MARK: Picker Customization
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var label: UILabel
//
//        if let view = view as? UILabel {
//            label = view
//        } else {
//            label = UILabel()
//        }
//
//        label.textColor = UIColor(named: .textTintColor)
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
//
//        switch component {
//        case 0:
////            label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
//            label.text = rovers[row].name
//        case 1:
////            label.font = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
//            label.text = cameras[row].abbreviation
//        default: label.text = "?"
//        }
//
//        return label
//    }
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        switch component {
//        case 0: return pickerView.frame.width * (2/5)
//        case 1: return pickerView.frame.width * (2/5)
//        case 2: return pickerView.frame.width * (1/5)
//        default:
//            return pickerView.frame.width * (1/3)
//        }
//    }
//}




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
