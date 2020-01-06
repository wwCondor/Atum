//
//  SlideMenuManager.swift
//  Atum
//
//  Created by Wouter Willebrands on 26/12/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit
import MessageUI

enum ModeSelected {
    case marsRoverMode
    case blueMarbleMode
}

class SliderMenuManager: NSObject {
    
    var modeSelected: ModeSelected = .marsRoverMode
    var addTextToImage: Bool = true
    
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
    
    lazy var emailInputField: EmailInputField = {
        let emailInputField = EmailInputField()
        emailInputField.text = PlaceHolderText.enterEmail
        return emailInputField
    }()
    
    lazy var sendButton: CustomButton = {
        let cameraSelectionButton = CustomButton(type: .custom)
        cameraSelectionButton.setTitle("Send", for: .normal)
        cameraSelectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        cameraSelectionButton.addTarget(self, action: #selector(sendMail(sender:)), for: .touchUpInside)
        return cameraSelectionButton
    }()
    
    lazy var selectedImageView: RetrievedImageView = {
        var image = UIImage(named: .placeholderImage)
        let selectedImageView = RetrievedImageView(image: image)
        return selectedImageView
    }()
    
    lazy var greetingTextField: PostcardGreetingField = {
        let greetingTextField = PostcardGreetingField()
        greetingTextField.text = PlaceHolderText.postcardDefaultMessage
        return greetingTextField
    }()
    
    lazy var roverInfoField: PostcardImageInfoField = {
        let roverInfoField = PostcardImageInfoField()
        roverInfoField.text = "?"
        return roverInfoField
    }()
    
    lazy var cameraInfoField: PostcardImageInfoField = {
        let cameraInfoField = PostcardImageInfoField()
        cameraInfoField.text = "?"
        return cameraInfoField
    }()
    
    lazy var dateInfoField: PostcardImageInfoField = {
        let dateInfoField = PostcardImageInfoField()
        dateInfoField.text = "?"
        return dateInfoField
    }()
    
    lazy var addTextInfoField: PostcardImageInfoField = {
        let addTextInfoField = PostcardImageInfoField()
        addTextInfoField.text = PlaceHolderText.sendImageWithText
        addTextInfoField.backgroundColor = UIColor(named: .appBackgroundColor)
        addTextInfoField.layer.masksToBounds = true
        addTextInfoField.layer.cornerRadius = Constant.smallCornerRadius
        return addTextInfoField
    }()
    
    lazy var addTextSwitch: UISwitch = {
        let addTextSwitch = UISwitch()
        addTextSwitch.addTarget(self, action: #selector(flipSwitch(sender:)), for: .valueChanged)
        addTextSwitch.translatesAutoresizingMaskIntoConstraints = false
        addTextSwitch.onTintColor = UIColor(named: .iconColor)
        addTextSwitch.thumbTintColor = UIColor(named: .objectBorderColor)
        return addTextSwitch
    }()
    
    override init() {
        super.init()
        emailInputField.delegate = self
        greetingTextField.delegate = self
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
            window.addSubview(roverInfoField)
            window.addSubview(cameraInfoField)
            window.addSubview(dateInfoField)
            
            window.addSubview(addTextInfoField)
            window.addSubview(addTextSwitch)
            
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
                emailInputField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -Constant.itemSpacing),
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
                dateInfoField.bottomAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: -2*Constant.textFieldPadding),
                
                addTextInfoField.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Constant.contentPadding),
                addTextInfoField.leadingAnchor.constraint(equalTo: selectedImageView.leadingAnchor),
                addTextInfoField.trailingAnchor.constraint(equalTo: addTextSwitch.leadingAnchor, constant: -Constant.itemSpacing),
                addTextInfoField.heightAnchor.constraint(equalToConstant: Constant.emailInputFieldHeight),
                
                addTextSwitch.centerYAnchor.constraint(equalTo: addTextInfoField.centerYAnchor, constant: 4),
                addTextSwitch.trailingAnchor.constraint(equalTo: selectedImageView.trailingAnchor, constant: 8),
                addTextSwitch.widthAnchor.constraint(equalToConstant: Constant.sendButtonSize),
                addTextSwitch.heightAnchor.constraint(equalToConstant: Constant.emailInputFieldHeight),
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
                    self.roverInfoField.center.y -= windowHeight
                    self.cameraInfoField.center.y -= windowHeight
                    self.dateInfoField.center.y -= windowHeight
                    self.addTextInfoField.center.y -= windowHeight
                    self.addTextSwitch.center.y -= windowHeight
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
                self.emailInputField.center.y += self.sliderView.bounds.height
                self.sendButton.center.y += self.sliderView.bounds.height
                self.selectedImageView.center.y += self.sliderView.bounds.height
                self.greetingTextField.center.y += self.sliderView.bounds.height
                self.roverInfoField.center.y += self.sliderView.bounds.height
                self.cameraInfoField.center.y += self.sliderView.bounds.height
                self.dateInfoField.center.y += self.sliderView.bounds.height
                self.addTextInfoField.center.y += self.sliderView.bounds.height
                self.addTextSwitch.center.y += self.sliderView.bounds.height
        },
            completion: { _ in
                self.fadeView.removeFromSuperview()
                self.sliderView.removeFromSuperview()
                self.emailInputField.removeFromSuperview()
                self.sendButton.removeFromSuperview()
                self.selectedImageView.removeFromSuperview()
                self.greetingTextField.removeFromSuperview()
                self.roverInfoField.removeFromSuperview()
                self.cameraInfoField.removeFromSuperview()
                self.dateInfoField.removeFromSuperview()
                self.addTextInfoField.removeFromSuperview()
                self.addTextSwitch.removeFromSuperview()
        })
    }
    
    private func shakeInputLabel() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: emailInputField.center.x - 5, y: emailInputField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: emailInputField.center.x + 5, y: emailInputField.center.y))
        emailInputField.layer.add(animation, forKey: "position")
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func sendEmail(to address: String, contentOf imageView: UIImageView, addText: Bool) {
        guard let image = imageView.image else { return }
        var messageBody: String = "This does not work"
        
        switch modeSelected {
        case .marsRoverMode: messageBody = PlaceHolderText.emailBodyTextMars
        case .blueMarbleMode: messageBody = PlaceHolderText.emailBodyTextDSCOVR
        }
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            if MFMailComposeViewController.canSendMail() {
                let composer = MFMailComposeViewController()
                composer.mailComposeDelegate = self
                composer.setToRecipients([address])
                composer.setSubject(PlaceHolderText.emailSubject)
                composer.setMessageBody(messageBody, isHTML: false)
                let point: CGPoint = CGPoint(x: Constant.textFieldPadding, y: Constant.textFieldPadding)
                
                guard let greeting = greetingTextField.text else { return }
                guard let roverName = roverInfoField.text else { return }
                guard let roverCamera = cameraInfoField.text else { return }
                guard let date = dateInfoField.text else { return }
                
                var drawText: String = "\(greeting)"
                
                switch modeSelected {
                case .marsRoverMode: drawText = "\(greeting). Photo: \(roverName) (\(roverCamera), \(date))"
                case .blueMarbleMode: drawText = "\(greeting). Photo: DSCOVR, \(date)"
                }
                // Depending on selection here image is created with or without text added
                let imageWithText = image.withText(forMode: modeSelected, drawText: drawText, inImage: image, atPoint: point).pngData()!
                let imageData: Data = addText ? imageWithText : image.pngData()!
                let uuid = UUID().uuidString
                composer.addAttachmentData(imageData, mimeType: "image/png", fileName: "Atum-\(uuid).png")
                window.rootViewController?.present(composer, animated: true, completion: nil)
            } else {
                greetingTextField.text = "Device cannot send mail"
            }
        }
    }
    
    // w.p.willebrands@hotmail.com
    @objc private func sendMail(sender: CustomButton) {
        guard let input = emailInputField.text else { return }
        
        if input.isEmpty || input == PlaceHolderText.enterEmail {
            shakeInputLabel()
        } else if isValidEmail(input) == true {
            if addTextToImage == true {
                sendEmail(to: input, contentOf: selectedImageView, addText: true) // send email with text
            } else if addTextToImage == false {
                sendEmail(to: input, contentOf: selectedImageView, addText: false) // send email without text
            }
        } else if isValidEmail(input) == false {
            shakeInputLabel()
            print("Enter valid email address")
        }
    }
    
    // MARK: Switch
    private func updateUIForSelectedMode() {
        if modeSelected == .marsRoverMode {
            addTextSwitch.isOn = true
            showTextFields()
        } else if modeSelected == .blueMarbleMode {
            hideTextFields()
            addTextSwitch.isOn = false
        }
    }
    
    private func showTextFields() {
        greetingTextField.isHidden = false
        roverInfoField.isHidden = false
        cameraInfoField.isHidden = false
        dateInfoField.isHidden = false
        addTextInfoField.text = PlaceHolderText.sendImageWithText
    }
    
    private func hideTextFields() {
        greetingTextField.isHidden = true
        roverInfoField.isHidden = true
        cameraInfoField.isHidden = true
        dateInfoField.isHidden = true
        addTextInfoField.text = PlaceHolderText.sendImageWithoutText
    }
    
    @objc private func flipSwitch(sender: UISwitch) {
        if sender.isOn {
            print("ON")
            addTextToImage = true
            showTextFields()
        } else {
            print("OFF")
            addTextToImage = false
            hideTextFields()
        }
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
        // Set max
        switch textField {
        case greetingTextField:
            let currentString = greetingTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxCharacters
        default:
            return true // Allows backspace
        }
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
        case greetingTextField:
            if input.isEmpty {
                greetingTextField.text = PlaceHolderText.postcardDefaultMessage
            }
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

extension SliderMenuManager: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let window = window {
            if error != nil {
                controller.dismiss(animated: true, completion: nil)
            } else {
                print("2")
                switch result {
                case .cancelled:
                    print(result)
                case .saved:
                    print(result)
                case .sent:
                    print(result)
                case .failed:
                    print(result)
                @unknown default:
                    print(result)
                }
                window.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
