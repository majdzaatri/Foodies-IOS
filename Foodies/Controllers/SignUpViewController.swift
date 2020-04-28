//
//  VC2.swift
//  Foodies
//
//  Created by Majd Zaatri on 20/04/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MaterialComponents

class SignUpViewController: UIViewController  {
    
    @IBOutlet weak var titleLabel: UILabel!
    var ref: DatabaseReference!
    
    let emailTF: MDCOutlinedTextField = {
        let emailTFComponents = MaterialComponentsStruct.TextField.init("Email", "example@company.com", 0.85, false)
        return emailTFComponents.initTextField()
    }()
    
    
    let usernameTF: MDCOutlinedTextField = {
       let usernameTFComponents = MaterialComponentsStruct.TextField.init("Username", "Enter a nickname", 0.85, false)
       return usernameTFComponents.initTextField()
    }()
    
    
    let passwordTF:MDCOutlinedTextField = {
        let passwordTFComponents = MaterialComponentsStruct.TextField.init("Password", "Enter a password", 0.85, true)
        return passwordTFComponents.initTextField()
    }()
    
    
    let signUpButton: MDCButton = {
        let signUpButtonContent = MaterialComponentsStruct.Button(200, 60, 0.85, 25, "Sign Up", .normal, UIFont.boldSystemFont(ofSize: 30), UIColor.white, Constants.AppColors.mainColor)
        return signUpButtonContent.initButton()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
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
    
       
    @objc func signupPressed(sender: Any)  {
        
        if let email = emailTF.text, let password = passwordTF.text, let username = usernameTF.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let e = error {
                    print(e)
                } else {
                    self.ref.child("users").child(result!.user.uid).setValue(["Email": email,"password": password,"username": username])
                    self.performSegue(withIdentifier: Constants.Segue.signUpCompleted, sender: self)
                }
            }
        }
    }
}



//MARK:  SignUp View Controller layouts and components
extension SignUpViewController {
    fileprivate func setupLayoutsAndComponents() {
           
           self.view.addSubview(emailTF)
           self.view.addSubview(usernameTF)
           self.view.addSubview(passwordTF)
           self.view.addSubview(signUpButton)
           
           //Enable autoLayout
           emailTF.translatesAutoresizingMaskIntoConstraints = false
           emailTF.autocorrectionType = .no
           usernameTF.translatesAutoresizingMaskIntoConstraints = false
           usernameTF.autocorrectionType = .no
           passwordTF.translatesAutoresizingMaskIntoConstraints = false
           passwordTF.autocorrectionType = .no
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
           signUpButton.addTarget(self, action: #selector(signupPressed(sender:)), for: .touchUpInside)
       }

}
