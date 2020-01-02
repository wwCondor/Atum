//
//  SkyEyeViewController.swift
//  Atum
//
//  Created by Wouter Willebrands on 31/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SkyEyeViewController: UIViewController {
    
    var widthAndHeightInDegrees: Float = 0.100 // 0.1 degrees = 11 km
    
    let selectableLocations: [String] = []
    
    lazy var skyEyeImageView: RetrievedImageView = {
        let image = UIImage(named: .satImagePlaceHolder)
        let skyEyeImageView = RetrievedImageView(image: image)
        return skyEyeImageView
    }()
    
    lazy var satelliteImageView: UIImageView = {
        let inset: CGFloat = Constant.sliderImageInsets
        let edgeIndets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let image = UIImage(named: .skyEyeIcon)?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(edgeIndets)
        let satelliteImageView = UIImageView(image: image)
        satelliteImageView.tintColor = UIColor(named: .iconColor)
        satelliteImageView.contentMode = .scaleAspectFit
        satelliteImageView.translatesAutoresizingMaskIntoConstraints = false
        satelliteImageView.backgroundColor = UIColor.clear
        return satelliteImageView
    }()
    
    lazy var zoomSlider: UISlider = {
        let zoomSlider = UISlider()
        zoomSlider.translatesAutoresizingMaskIntoConstraints = false
        zoomSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        zoomSlider.backgroundColor = UIColor.clear
        zoomSlider.minimumTrackTintColor = UIColor(named: .iconSelectedColor)
        zoomSlider.maximumTrackTintColor = UIColor(named: .iconColor)
        zoomSlider.thumbTintColor = UIColor(named: .objectBorderColor)
        zoomSlider.minimumValue = 0
        zoomSlider.maximumValue = 5
        zoomSlider.setValue(2, animated: true)
        zoomSlider.addTarget(self, action: #selector(setZoom(_:)), for: .valueChanged)
        return zoomSlider
    }()
    
    lazy var planetImageView: UIImageView = {
        let inset: CGFloat = Constant.sliderImageInsets
        let edgeIndets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let image = UIImage(named: .planetIcon)?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(edgeIndets)
        let planetImageView = UIImageView(image: image)
        planetImageView.tintColor = UIColor(named: .iconColor)
        planetImageView.contentMode = .scaleAspectFit
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        planetImageView.backgroundColor = UIColor.clear
        return planetImageView
    }()
    
    lazy var test2: UIImageView = {
        let test2 = UIImageView()
        test2.translatesAutoresizingMaskIntoConstraints = false
        test2.backgroundColor = UIColor.yellow
        return test2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .appBackgroundColor)
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(skyEyeImageView)
        view.addSubview(satelliteImageView)
        view.addSubview(zoomSlider)
        view.addSubview(planetImageView)
        view.addSubview(test2) // datePicker
        
        let viewWidth: CGFloat = view.frame.width
        let selectedImageSize: CGFloat = (3/4)*view.frame.width
        let contentPadding: CGFloat = (viewWidth - selectedImageSize) / 2
        let sliderWidth: CGFloat = Constant.sendButtonSize
        
        NSLayoutConstraint.activate([
            skyEyeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.contentPadding),
            skyEyeImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            skyEyeImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            skyEyeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Zoom Slider items
            satelliteImageView.topAnchor.constraint(equalTo: skyEyeImageView.bottomAnchor, constant: Constant.contentPadding),
            satelliteImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentPadding),
            satelliteImageView.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            satelliteImageView.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            
            zoomSlider.topAnchor.constraint(equalTo: satelliteImageView.bottomAnchor, constant: Constant.contentPadding),
            zoomSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentPadding),
            zoomSlider.widthAnchor.constraint(equalToConstant: sliderWidth),
            zoomSlider.bottomAnchor.constraint(equalTo: planetImageView.topAnchor, constant: -Constant.contentPadding),
            
            planetImageView.topAnchor.constraint(equalTo: zoomSlider.bottomAnchor, constant: Constant.contentPadding),
            planetImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentPadding),
            planetImageView.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            planetImageView.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            planetImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
            
            // picker
            test2.topAnchor.constraint(equalTo: skyEyeImageView.bottomAnchor, constant: Constant.contentPadding),
            test2.leadingAnchor.constraint(equalTo: zoomSlider.trailingAnchor, constant: Constant.contentPadding),
            test2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -contentPadding),
            test2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
        ])
    }
    
    @objc func setZoom(_ sender: UISlider) { // thumb size = 30x30
        //        view.endEditing(true)
        sender.value = roundf(sender.value) // this allows thumb to snap between values
        //        let radiiInMeters: [Float] = [0.025, 0.050, 0.100, 0.200, 0.500, 0.800]
        //        let radiusSelected = Double(radiiInMeters[Int(roundf(sender.value))])
        //        radiusInMeters = radiusSelected
        //        bubbleRadiusInfoField.text = "Bubble radius: \(radiusSelected.clean)m"
    }
}

