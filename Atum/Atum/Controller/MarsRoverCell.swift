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
    var selectedRover: String = Rover.opportunity.name
    var selectedCamera: String = RoverCamera.navcam.abbreviation
//    var selectedSol: Int = 1
    
//    var maxSolForSelectedRover: Int = 1
//    var totalSols = [Int]()
    
    let rovers: [Rover] = [Rover.opportunity, Rover.curiosity, Rover.spirit]
    let cameras: [RoverCamera] = [RoverCamera.navcam, RoverCamera.fhaz, RoverCamera.rhaz]
    
    var opportunitySols = [Int]()
    var curiositySols = [Int]()
    var spiritSols = [Int]()
    
//    var opportunityMaxSol: Int = 5
//    var curiosityMaxSol: Int = 8
//    var spiritMaxSol: Int = 12
    
    var photos: [Photo] = [Photo]()
    
//    func createSolArrays() {
//        switch selectedRover {
//        case Rover.opportunity.name:
//            opportunitySols += 1...opportunityMaxSol
//        case Rover.curiosity.name:
//            curiositySols += 1...curiosityMaxSol
//        case Rover.spirit.name:
//            spiritSols += 1...spiritMaxSol
//        default: break
//        }
////        roverPhotoSearchPicker.reloadComponent(2)
//    }
    
    func fetchPhotoData() {
        for rover in rovers {
            RoverPhotoDataManager.fetchPhotos(rover: rover.name, sol: Int.random(in: 1...2000), camera: selectedCamera) { (photos, error) in
                DispatchQueue.main.async {
                    guard let photos = photos else {
                        print("No photos")
                        //                        print(error?.localizedDescription)
                        return
                    }
                    self.photos = photos
                    print(photos)
                }
            }
        }
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
        roverInfoField.text = "Curiosity"
        return roverInfoField
    }()
    
    lazy var cameraInfoField: PostcardImageInfoField = {
        let cameraInfoField = PostcardImageInfoField()
        cameraInfoField.text = "FHAZ"
        return cameraInfoField
    }()
    
    lazy var dateInfoField: PostcardImageInfoField = {
        let dateInfoField = PostcardImageInfoField()
        dateInfoField.text = "2012-08-06"
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
    
    lazy var roverPhotoSearchPicker: UIPickerView = {
        let roverPhotoSearchPicker = UIPickerView()
        roverPhotoSearchPicker.translatesAutoresizingMaskIntoConstraints = false
        roverPhotoSearchPicker.backgroundColor = UIColor.clear
        roverPhotoSearchPicker.delegate = self
        roverPhotoSearchPicker.dataSource = self
        return roverPhotoSearchPicker
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
        cellContentView.addSubview(greetingTextField)
        cellContentView.addSubview(roverInfoField)
        cellContentView.addSubview(cameraInfoField)
        cellContentView.addSubview(dateInfoField)
        
        cellContentView.addSubview(roverPhotoSearchPicker)
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
            
            roverPhotoSearchPicker.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            roverPhotoSearchPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.contentSidePadding),
            roverPhotoSearchPicker.trailingAnchor.constraint(equalTo: selectedImageView.centerXAnchor), // constant: -Constant.contentSidePadding),
            roverPhotoSearchPicker.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -Constant.contentPadding),

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
extension MarsRoverCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // We have 3 search input parameters for the users: Rover, Camera and Sol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return rovers.count
        case 1: return cameras.count
        default: return 1
        }
    }
    
//     Data being returned for each column
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return rovers[row].name
        case 1: return cameras[row].abbreviation
        default:
            return "x"
        }
    }
    
    // This part updates the selected categories
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedRover = rovers[row].name
            roverInfoField.text = rovers[row].name
            print(selectedRover)
        case 1:
            selectedCamera = cameras[row].abbreviation
            cameraInfoField.text = cameras[row].abbreviation
            print(selectedCamera)
        default: selectedCamera = cameras[row].abbreviation
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
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        
        switch component {
        case 0: label.text = rovers[row].name
        case 1: label.text = cameras[row].abbreviation
        default: label.text = "?"
        }
        
        return label
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0: return pickerView.frame.width * (1/2)
        case 1: return pickerView.frame.width * (1/2)
        default:
            return pickerView.frame.width * (1/2)
        }
    }
}




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
