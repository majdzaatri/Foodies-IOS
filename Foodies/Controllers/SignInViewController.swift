//
//  SignInViewController.swift
//  Foodies
//
//  Created by Majd Zaatri on 24/04/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons_Theming
import Firebase
import FBSDKLoginKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //email textField
    let emailTF: MDCOutlinedTextField = {
        let emailTFComponents = MaterialComponentsStruct.TextField.init("Email", "example@company.com", 0.85, false)
        return emailTFComponents.initTextField()
    }()
    
    //password textField
    let passwordTF: MDCOutlinedTextField = {
        let passwordTFComponents = MaterialComponentsStruct.TextField.init("Password", "Enter your password", 0.85, true)
        return passwordTFComponents.initTextField()
    }()
    
    //signin Button
    let signInButton: MDCButton = {
            let signInButtonContent = MaterialComponentsStruct.Button(200, 60, 0.85, 25, "Sign in", .normal, UIFont.boldSystemFont(ofSize: 30), UIColor.white, Constants.AppColors.mainColor)
        return signInButtonContent.initButton()
    }()
    
    let loginButton = FBLoginButton()

    override func viewDidLoad() {
         
        titleAnimation()
        setupLayoutsAndComponents()

        loginButton.center = view.center
        loginButton.delegate = self
        
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
    
   
    
    @objc func signinPressed(sender: Any) {
        
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: Constants.Segue.signInCompleted, sender: self)
                }
            }
        }
    }
}


//MARK: SignIn View Controller layouts and components
extension SignInViewController {
    
    fileprivate func setupLayoutsAndComponents() {

           self.view.addSubview(emailTF)
           self.view.addSubview(passwordTF)
           self.view.addSubview(signInButton)
           self.view.addSubview(loginButton)
           
           emailTF.translatesAutoresizingMaskIntoConstraints = false
           emailTF.autocorrectionType = .no
           NSLayoutConstraint.activate([
               emailTF.heightAnchor.constraint(equalToConstant: 50),
               emailTF.widthAnchor.constraint(equalToConstant: 300),
               emailTF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               emailTF.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 100)
           ])
           emailTF.sizeToFit()
           
           passwordTF.translatesAutoresizingMaskIntoConstraints = false
           passwordTF.autocorrectionType = .no
           NSLayoutConstraint.activate([
               passwordTF.heightAnchor.constraint(equalToConstant: 50),
               passwordTF.widthAnchor.constraint(equalToConstant: 300),
               passwordTF.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 50)
           ])
           passwordTF.sizeToFit()

           signInButton.layer.shadowOffset = CGSize(width: 2, height: 5)
           signInButton.layer.shadowRadius = 5
           signInButton.layer.shadowOpacity = 1.0
                   
           signInButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               signInButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
           ])
           signInButton.addTarget(self, action: #selector(signinPressed(sender:)), for: .touchUpInside)
       }
}


//MARK: SignInViewController facebook LoginButtonDelegate
extension SignInViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("loged out")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let e = error {
            print(e)
        } else {
            self.performSegue(withIdentifier: Constants.Segue.signInCompleted, sender: self)
        }
    }
}
