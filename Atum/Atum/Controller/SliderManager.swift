//
//  SlideMenuManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 26/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

enum ModeSelected {
    case marsRoverMode
    case blueMarbleMode
}

class SliderMenuManager: NSObject {
    
    var modeSelected: ModeSelected = .marsRoverMode
            
    lazy var selectedImageView: RetrievedImageView = {
        var image = UIImage(named: .placeholderImage)
        let selectedImageView = RetrievedImageView(image: image)
        return selectedImageView
    }()
    
    lazy var greetingTextField: PostcardGreetingField = {
        let greetingTextField = PostcardGreetingField()
        greetingTextField.text = PlaceHolderText.postcardDefaultMessage
        greetingTextField.backgroundColor = UIColor.clear
        return greetingTextField
    }()
    
    lazy var emailInputField: EmailInputField = {
        let emailInputField = EmailInputField()
        emailInputField.text = PlaceHolderText.enterEmail
        return emailInputField
    }()

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
    
    lazy var sendButton: CustomButton = {
        let cameraSelectionButton = CustomButton(type: .custom)
        cameraSelectionButton.setTitle("Send", for: .normal)
        cameraSelectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        cameraSelectionButton.addTarget(self, action: #selector(sendImage(sender:)), for: .touchUpInside)
        return cameraSelectionButton
    }()

    override init() {
        super.init()
        emailInputField.delegate = self
        greetingTextField.delegate = self
    }
    
    private func updateUIForSelectedMode() {
        if modeSelected == .marsRoverMode {
            greetingTextField.isHidden = false
        } else if modeSelected == .blueMarbleMode {
            greetingTextField.isHidden = true
        }
    }

    func presentSlider() {
        updateUIForSelectedMode()
        hideKeyboardOnBackgroundTap()

        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {

            window.addSubview(fadeView)
            window.addSubview(sliderView)
            window.addSubview(emailInputField)
            window.addSubview(sendButton)
            window.addSubview(selectedImageView)
            window.addSubview(greetingTextField)
            
            fadeView.frame = window.frame
            
            let windowHeight: CGFloat = window.frame.height
            let contentSize: CGFloat = (3/4)*window.frame.width
            
            NSLayoutConstraint.activate([
                sliderView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                sliderView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                sliderView.topAnchor.constraint(equalTo: window.centerYAnchor, constant: -window.frame.height/4),
                sliderView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                
                emailInputField.topAnchor.constraint(equalTo: sliderView.topAnchor, constant: Constant.contentPadding),
                emailInputField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
                emailInputField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
                emailInputField.heightAnchor.constraint(equalToConstant: Constant.emailInputFieldHeight),
                
                sendButton.topAnchor.constraint(equalTo: sliderView.topAnchor, constant: Constant.contentPadding),
                sendButton.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
                sendButton.heightAnchor.constraint(equalToConstant: Constant.emailInputFieldHeight),
                sendButton.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor),
                
                selectedImageView.topAnchor.constraint(equalTo: emailInputField.bottomAnchor, constant: Constant.contentPadding),
                selectedImageView.widthAnchor.constraint(equalToConstant: contentSize),
                selectedImageView.heightAnchor.constraint(equalToConstant: contentSize),
                selectedImageView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                
                greetingTextField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: Constant.contentSidePadding),
                greetingTextField.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: -Constant.contentSidePadding),
                greetingTextField.centerYAnchor.constraint(equalTo: selectedImageView.centerYAnchor),
                greetingTextField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
            ])

            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.fadeView.alpha = 0.4
                    self.sliderView.center.y -= windowHeight
                    self.emailInputField.center.y -= windowHeight
                    self.sendButton.center.y -= windowHeight
                    self.selectedImageView.center.y -= windowHeight
                    self.greetingTextField.center.y -= windowHeight
            },
                completion: nil)
        }
    }
    
    @objc private func dismissSlider(sender: UISwipeGestureRecognizer) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.fadeView.alpha = 0
                self.sliderView.center.y += self.sliderView.bounds.height
                self.emailInputField.center.y += self.sliderView.bounds.height
                self.sendButton.center.y += self.sliderView.bounds.height
                self.selectedImageView.center.y += self.sliderView.bounds.height
                self.greetingTextField.center.y += self.sliderView.bounds.height

        },
            completion: { _ in
                self.fadeView.removeFromSuperview()
                self.sliderView.removeFromSuperview()
                self.emailInputField.removeFromSuperview()
                self.sendButton.removeFromSuperview()
                self.selectedImageView.removeFromSuperview()
                self.greetingTextField.removeFromSuperview()
        })
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: 13.0, weight: .medium)

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    @objc private func sendImage(sender: CustomButton) {
        // In here we should
        print("Sent!")
    }
}

extension SliderMenuManager: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder() // show Keyboard when user taps textField
        // If current text is placeholder text, reset it to ""
        guard let text = textField.text else { return }
        switch textField {
        case emailInputField:
            if text == PlaceHolderText.enterEmail {
                emailInputField.text = ""
            }
        case greetingTextField:
            if text == PlaceHolderText.postcardDefaultMessage {
                greetingTextField.text = ""
            }
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxCharacters = 25
        
        switch textField {
        case emailInputField:
            // Makes sure all input is lowercase
            if let _ = string.rangeOfCharacter(from: .uppercaseLetters) {
                return false
            }
        case greetingTextField:
            let currentString = greetingTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxCharacters
        default:
            return true // Allows backspace
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // If input field is empty, placeholder text is restored
        textField.resignFirstResponder()
        guard let input = textField.text else { return }
        switch textField {
        case emailInputField:
            if input.isEmpty {
                emailInputField.text = PlaceHolderText.enterEmail
            }
//        case greetingTextField:
//            if input.isEmpty {
//                greetingTextField.text = PlaceHolderText.postcardDefaultMessage
//            }
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss Keyboard if "return" is tapped
        textField.resignFirstResponder()
        return true
    }
}
