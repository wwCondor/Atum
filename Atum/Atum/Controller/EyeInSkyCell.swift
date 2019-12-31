//
//  EyeInSkyCell.swift
//  Atum
//
//  Created by Wouter Willebrands on 29/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit
import MapKit

class EyeInSkyCell: BaseCell {
    
    var widthAndHeightInDegrees: Float = 0.100 // 0.1 degrees = 11 km
    
    let regionInMeters: Double = 11000 // 0.01 * 1.10574 in km

    lazy var cellContentView: CellContentView = {
        let cellContentView = CellContentView()
        cellContentView.backgroundColor = UIColor(named: .appBackgroundColor)
        return cellContentView
    }()
    
    lazy var skyEyeImageView: UIImageView = {
        let image = UIImage(named: .satImagePlaceHolder)
        let skyEyeImageView = UIImageView(image: image)
        skyEyeImageView.contentMode = .scaleAspectFit
        skyEyeImageView.backgroundColor = UIColor.yellow
        skyEyeImageView.layer.masksToBounds = true
        skyEyeImageView.layer.cornerRadius = Constant.largeCornerRadius
        skyEyeImageView.translatesAutoresizingMaskIntoConstraints = false
        return skyEyeImageView
    }()
    
//    lazy var mapView: MKMapView = {
//        let mapView = MKMapView()
//        mapView.overrideUserInterfaceStyle = .dark
//        mapView.isUserInteractionEnabled = false
//        mapView.isZoomEnabled = false
//        mapView.layer.masksToBounds = true
//        mapView.layer.cornerRadius = Constant.largeCornerRadius
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        return mapView
//    }()
    
//    lazy var locationInfoField: CustomTextField = {
//        let locationInfoField = CustomTextField()
//        locationInfoField.isUserInteractionEnabled = false
//        locationInfoField.text = "Placeholder Text"
//        return locationInfoField
//    }()
    
    lazy var test2: UIImageView = {
        let test2 = UIImageView()
        test2.translatesAutoresizingMaskIntoConstraints = false
        test2.backgroundColor = UIColor.yellow
        return test2
    }()
    
    //    lazy var test3: UIImageView = {
    //        let test3 = UIImageView()
    //        test3.translatesAutoresizingMaskIntoConstraints = false
    //        test3.backgroundColor = UIColor.black
    //        return test3
    //    }()
    
    lazy var satelliteImageView: UIImageView = {
        let inset: CGFloat = -Constant.sendButtonIconInset
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
        let inset: CGFloat = -Constant.sendButtonIconInset
        let edgeIndets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let image = UIImage(named: .planetIcon)?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(edgeIndets)
        let planetImageView = UIImageView(image: image)
        planetImageView.tintColor = UIColor(named: .iconColor)
        planetImageView.contentMode = .scaleAspectFit
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        planetImageView.backgroundColor = UIColor.clear

        return planetImageView
    }()
    

    
    override func setupView() {
        addSubview(cellContentView)
        
        cellContentView.addSubview(skyEyeImageView)
//        cellContentView.addSubview(mapView)
        cellContentView.addSubview(satelliteImageView)
        cellContentView.addSubview(zoomSlider)
        cellContentView.addSubview(planetImageView)

        cellContentView.addSubview(test2) // datePicker


        let viewWidth: CGFloat = frame.width
        let selectedImageSize: CGFloat = (3/4)*frame.width
        let contentPadding: CGFloat = (viewWidth - selectedImageSize) / 2
        let sliderWidth: CGFloat = Constant.sendButtonSize

        NSLayoutConstraint.activate([
            // view containing cell content
            cellContentView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.navigationBarHeight),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cellContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.menuBarHeight),
            
            skyEyeImageView.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: Constant.contentPadding),
            skyEyeImageView.widthAnchor.constraint(equalToConstant: selectedImageSize),
            skyEyeImageView.heightAnchor.constraint(equalToConstant: selectedImageSize),
            skyEyeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Zoom Slider items
            satelliteImageView.topAnchor.constraint(equalTo: skyEyeImageView.bottomAnchor, constant: Constant.contentPadding),
            satelliteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentPadding),
            satelliteImageView.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            satelliteImageView.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            
            zoomSlider.topAnchor.constraint(equalTo: satelliteImageView.bottomAnchor, constant: Constant.contentPadding),
            zoomSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentPadding),
            zoomSlider.widthAnchor.constraint(equalToConstant: sliderWidth),
            zoomSlider.bottomAnchor.constraint(equalTo: planetImageView.topAnchor, constant: -Constant.contentPadding),
            
            planetImageView.topAnchor.constraint(equalTo: zoomSlider.bottomAnchor, constant: Constant.contentPadding),
            planetImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentPadding),
            planetImageView.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            planetImageView.heightAnchor.constraint(equalToConstant: Constant.sendButtonSize),
            planetImageView.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -Constant.contentPadding),
            
            

            test2.topAnchor.constraint(equalTo: skyEyeImageView.bottomAnchor, constant: Constant.contentPadding),
            test2.leadingAnchor.constraint(equalTo: zoomSlider.trailingAnchor, constant: Constant.contentPadding),
            test2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentPadding),
            test2.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -Constant.contentPadding),
            

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
