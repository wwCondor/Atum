//
//  LocationSliderManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 09/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit
import MapKit

class LocationManagerSlider: NSObject {
    
    let cellId = "locationCell"
    
    lazy var fadeView: UIView = {
        let fadeView = UIView()
        fadeView.alpha = 0
        fadeView.backgroundColor = UIColor.black
        fadeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSlider(sender:))))
        return fadeView
    }()
    
    lazy var sliderView: UIView = {
        let sliderView = UIView()
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.backgroundColor = UIColor(named: .objectColor)
        sliderView.layer.masksToBounds = true
        sliderView.addBorders(edges: [.top], color: UIColor(named: .objectBorderColor)!)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissSlider(sender:)))
        swipeGesture.direction = .down
        sliderView.addGestureRecognizer(swipeGesture)
        return sliderView
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        let locationSearchBar = UISearchBar()
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        locationSearchBar.isTranslucent = false
//        locationSearchBar.delegate = self
        locationSearchBar.placeholder = PlaceHolderText.enterLocation
        locationSearchBar.layer.masksToBounds = true
        locationSearchBar.layer.cornerRadius = Constant.smallCornerRadius
        locationSearchBar.layer.borderWidth = Constant.textFieldBorderWidth
        locationSearchBar.layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        locationSearchBar.searchTextField.backgroundColor = UIColor.clear // Gets rid of colored padding
        locationSearchBar.barTintColor = UIColor(named: .appBackgroundColor)
        locationSearchBar.tintColor = UIColor(named: .iconSliderColor) // Sets vertical bar "caret" color
        locationSearchBar.searchTextField.textColor = UIColor(named: .textTintColor)
        locationSearchBar.searchTextField.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        locationSearchBar.keyboardAppearance = .dark
        locationSearchBar.returnKeyType = .done
        return locationSearchBar
    }()
    
    lazy var searchResultsTableView: UITableView = {
        let searchResultsTableView = UITableView()
        searchResultsTableView.backgroundColor = UIColor(named: .appBackgroundColor)
        searchResultsTableView.layer.masksToBounds = true
        searchResultsTableView.layer.cornerRadius = Constant.largeCornerRadius
//        searchResultsTableView.layer.borderWidth = Constant.sliderMenuBorderWidth
//        searchResultsTableView.layer.borderColor = UIColor(named: .objectBorderColor)?.cgColor
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
//        searchResultsTableView.dataSource = self
//        searchResultsTableView.delegate = self
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        return searchResultsTableView
    }()
    
    override init() {
        super.init()

    }
    
    func presentSlider() {

        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            
            window.addSubview(fadeView)
            window.addSubview(sliderView)
            window.addSubview(locationSearchBar)
            window.addSubview(searchResultsTableView)

            fadeView.frame = window.frame
            
            let windowHeight: CGFloat = window.frame.height
            let contentWidth: CGFloat = (3/4)*window.frame.width

            NSLayoutConstraint.activate([
                sliderView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                sliderView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                sliderView.topAnchor.constraint(equalTo: window.centerYAnchor),// constant: -window.frame.height/4),
                sliderView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                                
                locationSearchBar.topAnchor.constraint(equalTo: sliderView.topAnchor, constant: Constant.contentPadding),
                locationSearchBar.widthAnchor.constraint(equalToConstant: contentWidth),
                locationSearchBar.heightAnchor.constraint(equalToConstant: Constant.emailInputFieldHeight),
                locationSearchBar.centerXAnchor.constraint(equalTo: sliderView.centerXAnchor),
                
                searchResultsTableView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor, constant: Constant.contentPadding),
                searchResultsTableView.leadingAnchor.constraint(equalTo: locationSearchBar.leadingAnchor),
                searchResultsTableView.trailingAnchor.constraint(equalTo: locationSearchBar.trailingAnchor),
                searchResultsTableView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomContentPadding),
//                selectedImageView.topAnchor.constraint(equalTo: emailInputField.bottomAnchor, constant: Constant.contentPadding),
//                selectedImageView.widthAnchor.constraint(equalToConstant: contentSize),
//                selectedImageView.heightAnchor.constraint(equalToConstant: contentSize),
//                selectedImageView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            ])
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.fadeView.alpha = 0.4
                    self.sliderView.center.y -= windowHeight
                    self.locationSearchBar.center.y -= windowHeight
                    self.searchResultsTableView.center.y -= windowHeight
//                    self.selectedImageView.center.y -= windowHeight
//                    self.greetingTextField.center.y -= windowHeight
//                    self.roverInfoField.center.y -= windowHeight
//                    self.cameraInfoField.center.y -= windowHeight
//                    self.dateInfoField.center.y -= windowHeight
//                    self.addTextInfoField.center.y -= windowHeight
//                    self.addTextSwitch.center.y -= windowHeight
            },
                completion: nil)
        }
    }
    
    @objc private func dismissSlider(sender: UISwipeGestureRecognizer) {
        dismissSliderMenu()
    }
    
    private func dismissSliderMenu() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.fadeView.alpha = 0
                self.sliderView.center.y += self.sliderView.bounds.height
                self.locationSearchBar.center.y += self.sliderView.bounds.height
                self.searchResultsTableView.center.y += self.sliderView.bounds.height
//                self.selectedImageView.center.y += self.sliderView.bounds.height
//                self.greetingTextField.center.y += self.sliderView.bounds.height
//                self.roverInfoField.center.y += self.sliderView.bounds.height
//                self.cameraInfoField.center.y += self.sliderView.bounds.height
//                self.dateInfoField.center.y += self.sliderView.bounds.height
//                self.addTextInfoField.center.y += self.sliderView.bounds.height
//                self.addTextSwitch.center.y += self.sliderView.bounds.height
        },
            completion: { _ in
                self.fadeView.removeFromSuperview()
                self.sliderView.removeFromSuperview()
                self.locationSearchBar.removeFromSuperview()
                self.searchResultsTableView.removeFromSuperview()
//                self.selectedImageView.removeFromSuperview()
//                self.greetingTextField.removeFromSuperview()
//                self.roverInfoField.removeFromSuperview()
//                self.cameraInfoField.removeFromSuperview()
//                self.dateInfoField.removeFromSuperview()
//                self.addTextInfoField.removeFromSuperview()
//                self.addTextSwitch.removeFromSuperview()
        })
    }
}
