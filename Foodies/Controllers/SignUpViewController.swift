//
//  VC2.swift
//  Foodies
//
//  Created by Majd Zaatri on 20/04/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController  {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        signUpButton.layer.cornerRadius = 25
//        signUpButton.layer.shadowColor = UIColor.black.cgColor
//        signUpButton.layer.shadowOffset = CGSize(width: 2, height: 5)
//        signUpButton.layer.shadowRadius = 5
//        signUpButton.layer.shadowOpacity = 1.0
         
        titleAnimation()
        setupLayoutsAndComponents()
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func titleAnimation() {
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = Constants.appNameWithSpaces
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    fileprivate func setupLayoutsAndComponents() {
        
        let emailTFComponents = MaterialComponentsStruct.TextField.init("Email", "example@company.com", 0.85, false)
        let emailTF = emailTFComponents.initTextField()
        
        let usernameTFComponents = MaterialComponentsStruct.TextField.init("Username", "Enter a nickname", 0.85, false)
        let usernameTF = usernameTFComponents.initTextField()
        
        let passwordTFComponents = MaterialComponentsStruct.TextField.init("Password", "Enter a password", 0.85, true)
        let passwordTF = passwordTFComponents.initTextField()
        
        let signUpButtonContent = MaterialComponentsStruct.Button(200, 60, 0.85, 25, "Sign Up", .normal, UIFont.boldSystemFont(ofSize: 30), UIColor.white, Constants.AppColors.mainColor)
        let signUpButton = signUpButtonContent.initButton()
        
        
        self.view.addSubview(emailTF)
        self.view.addSubview(usernameTF)
        self.view.addSubview(passwordTF)
        self.view.addSubview(signUpButton)
        
        //Enable autoLayout
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        usernameTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTF.widthAnchor.constraint(equalToConstant: 300),
            emailTF.heightAnchor.constraint(equalToConstant: 50),
            emailTF.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 100)
        ])
        emailTF.sizeToFit()
        
        NSLayoutConstraint.activate([
            usernameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTF.widthAnchor.constraint(equalToConstant: 300),
            usernameTF.heightAnchor.constraint(equalToConstant: 50),
            usernameTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 50)
        ])
        usernameTF.sizeToFit()
        
        NSLayoutConstraint.activate([
            passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTF.widthAnchor.constraint(equalToConstant: 300),
            passwordTF.heightAnchor.constraint(equalToConstant: 50),
            passwordTF.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 50)
        ])
        passwordTF.sizeToFit()
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 70)
        ])
        signUpButton.layer.shadowOffset =  CGSize(width: 2, height: 5)
        signUpButton.layer.shadowRadius = 5
        signUpButton.layer.shadowOpacity = 1.0
    }
}
