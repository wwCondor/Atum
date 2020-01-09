//
//  LocationSliderManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 09/01/2020.
//  Copyright © 2020 Studio Willebrands. All rights reserved.
//

import UIKit

class LocationManagerSlider: NSObject {
    
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
    
    override init() {
        super.init()

    }
    
    func presentSlider() {

        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            
            window.addSubview(fadeView)
            window.addSubview(sliderView)

            
            fadeView.frame = window.frame
            
            let windowHeight: CGFloat = window.frame.height
            
            NSLayoutConstraint.activate([
                sliderView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                sliderView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                sliderView.topAnchor.constraint(equalTo: window.centerYAnchor),// constant: -window.frame.height/4),
                sliderView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            ])
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.fadeView.alpha = 0.4
                    self.sliderView.center.y -= windowHeight
//                    self.emailInputField.center.y -= windowHeight
//                    self.sendButton.center.y -= windowHeight
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
//                self.emailInputField.center.y += self.sliderView.bounds.height
//                self.sendButton.center.y += self.sliderView.bounds.height
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
//                self.emailInputField.removeFromSuperview()
//                self.sendButton.removeFromSuperview()
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
