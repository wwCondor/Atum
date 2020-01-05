//
//  SkyEyeViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SkyEyeViewController: UIViewController {
        
    let selectableLocations: [Location] = [.mountEverest, .edinBurghCastle, .pyramidOfGiza, .eiffelTower, .colosseum, .christTheRedeemer, .chichenItza, .machuPichu, .towerOfPisa, .chineseWall, .uluru, .grandCanyon, .paricutin, .oukaimeden, .northernLight, .victoriaFalls]
    
    lazy var selectedImageView: RetrievedImageView = {
        let image = UIImage(named: .placeholderImage)
        let selectedImageView = RetrievedImageView(image: image)
        return selectedImageView
    }()
    
//    lazy var satelliteIcon: UIImageView = {
//        let inset: CGFloat = Constant.sliderImageInsets
//        let edgeIndets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//        let image = UIImage(named: .skyEyeIcon)?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(edgeIndets)
//        let satelliteIcon = UIImageView(image: image)
//        satelliteIcon.tintColor = UIColor(named: .iconColor)
//        satelliteIcon.contentMode = .scaleAspectFit
//        satelliteIcon.translatesAutoresizingMaskIntoConstraints = false
//        satelliteIcon.backgroundColor = UIColor.clear
//        return satelliteIcon
//    }()
    
//    lazy var sliderBackground: UIImageView = {
//        let sliderBackground = UIImageView()
//        sliderBackground.translatesAutoresizingMaskIntoConstraints = false
//        sliderBackground.backgroundColor = UIColor(named: .objectColor)
//        sliderBackground.layer.masksToBounds = true
//        sliderBackground.layer.cornerRadius = Constant.smallCornerRadius
//        sliderBackground.layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
//        sliderBackground.layer.borderWidth = Constant.sendButtonBorderWidth
//        return sliderBackground
//    }()
//
//    lazy var zoomSlider: UISlider = {
//        let zoomSlider = UISlider()
//        zoomSlider.translatesAutoresizingMaskIntoConstraints = false
//        zoomSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
//        zoomSlider.backgroundColor = UIColor.clear
//        zoomSlider.maximumTrackTintColor = UIColor(named: .iconColor)
//        zoomSlider.minimumTrackTintColor = UIColor(named: .iconSelectedColor)
//        zoomSlider.thumbTintColor = UIColor(named: .objectBorderColor)
//        zoomSlider.minimumValue = 0
//        zoomSlider.maximumValue = 4
//        zoomSlider.setValue(1, animated: true)
//        zoomSlider.addTarget(self, action: #selector(setZoom(_:)), for: .valueChanged)
//        return zoomSlider
//    }()
    
//    lazy var planetIcon: UIImageView = {
//        let inset: CGFloat = Constant.sliderImageInsets
//        let edgeIndets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//        let image = UIImage(named: .planetIcon)?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(edgeIndets)
//        let planetIcon = UIImageView(image: image)
//        planetIcon.tintColor = UIColor(named: .iconColor)
//        planetIcon.contentMode = .scaleAspectFit
//        planetIcon.translatesAutoresizingMaskIntoConstraints = false
//        planetIcon.backgroundColor = UIColor.clear
//        return planetIcon
//    }()
    
    lazy var locationPicker: UIPickerView = {
        let locationPicker = UIPickerView()
        locationPicker.translatesAutoresizingMaskIntoConstraints = false
        locationPicker.backgroundColor = UIColor.clear
        locationPicker.delegate = self
        locationPicker.dataSource = self
        return locationPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)

        setupView()
        getEyeInTheSkyPhoto()
    }
    
    private func getEyeInTheSkyPhoto() {
        EyeInTheSkyDataManager.fetchPhoto(lat: SkyEyeQueryData.userEyeDataSelections.selectedLocation.latitude , long: SkyEyeQueryData.userEyeDataSelections.selectedLocation.longitude, dim: SkyEyeQueryData.userEyeDataSelections.selectedZoomLevel) { (data, error) in
            DispatchQueue.main.async {
                guard let photoData = data else {
                    self.selectedImageView.image = UIImage(named: .placeholderImage)
                    self.presentAlert(description: NetworkingError.noData.localizedDescription, viewController: self)
                    return
                }
                self.selectedImageView.fetchPhoto(from: photoData.url)
//                print(photoData)
            }
        }
    }
    
    private func setupView() {
        view.addSubview(selectedImageView)
        
//        view.addSubview(satelliteIcon)
//        view.addSubview(sliderBackground)
//        sliderBackground.addSubview(zoomSlider)
//        view.addSubview(planetIcon)
        
        view.addSubview(locationPicker)

        let selectedImageSize: CGFloat = (3/4)*view.frame.width
        
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.contentPadding),
            selectedImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            selectedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Zoom Slider items
//            satelliteIcon.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
//            satelliteIcon.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
//            satelliteIcon.widthAnchor.constraint(equalToConstant: Constant.sliderImageViewSize),
//            satelliteIcon.heightAnchor.constraint(equalToConstant: Constant.sliderImageViewSize),
            
//            sliderBackground.topAnchor.constraint(equalTo: satelliteIcon.bottomAnchor),
//            sliderBackground.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
//            sliderBackground.widthAnchor.constraint(equalToConstant: Constant.sliderImageViewSize),
//            sliderBackground.bottomAnchor.constraint(equalTo: planetIcon.topAnchor),
//
//            zoomSlider.topAnchor.constraint(equalTo: sliderBackground.topAnchor),
//            zoomSlider.widthAnchor.constraint(equalToConstant: Constant.sliderImageViewSize),
//            zoomSlider.bottomAnchor.constraint(equalTo: sliderBackground.bottomAnchor),
            
//            planetIcon.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
//            planetIcon.widthAnchor.constraint(equalToConstant: Constant.sliderImageViewSize),
//            planetIcon.heightAnchor.constraint(equalToConstant: Constant.sliderImageViewSize),
//            planetIcon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
            
            // picker
            locationPicker.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
            locationPicker.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),// constant: Constant.contentPadding),
            locationPicker.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
            locationPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
        ])
    }
    
    @objc func setZoom(_ sender: UISlider) {
//        sender.value = roundf(sender.value) // this allows thumb to snap between values
//        let zoomLevel: [Float] = [0.025, 0.050, 0.100, 0.200, 0.500]
//        let zoomSelected = Double(zoomLevel[Int(roundf(sender.value))])
//        SkyEyeQueryData.userEyeDataSelections.selectedZoomLevel = "\(zoomSelected)"
    }
}

extension SkyEyeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectableLocations.count
    }
    
    // Data being returned for each column
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectableLocations[row].locationName
    }
    
    // Action after selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SkyEyeQueryData.userEyeDataSelections.selectedLocation = selectableLocations[row]
        getEyeInTheSkyPhoto()
    }
    
    // Customization
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
        
        if selectableLocations.count == 0 {
            label.text = "No dates obtained"
        } else {
            label.text = selectableLocations[row].locationName
        }
        
        return label
    }
}
