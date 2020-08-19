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
import FBSDKCoreKit

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
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        let attributedText: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: Constants.AppColors.mainColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        label.adjustsFontSizeToFitWidth = true
        let myAttrString = NSAttributedString(string: "Don't have an account yet?", attributes: attributedText)
        label.attributedText = myAttrString
        return label
    }()
    
    let signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitle("sign up", for: .normal)
        signUpButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return signUpButton
    }()
    
    
    
    
    
    let loginButton = FBLoginButton()

    override func viewDidLoad() {
         
        titleAnimation()
        setupLayoutsAndComponents()


        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            
            request.start(completionHandler: { connection, result, error in
                print("☢️\(String(describing: result))")
                if (result != nil) {
                    self.performSegue(withIdentifier: Constants.Segue.signInCompleted, sender: self)
                }
            })
            
        } else {
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
        }
        
        
    }
    
    
    //Hide navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    @objc func signUpPressed(sender: Any) {
        self.performSegue(withIdentifier: Constants.Segue.changeToSignUp, sender: self)
    }
}


//MARK: SignIn View Controller layouts and components
extension SignInViewController {
    
    fileprivate func setupLayoutsAndComponents() {

           self.view.addSubview(emailTF)
           self.view.addSubview(passwordTF)
           self.view.addSubview(signInButton)
           self.view.addSubview(loginButton)
           self.view.addSubview(signUpLabel)
           self.view.addSubview(signUpButton)
           
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
               signInButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 30)
           ])
           signInButton.addTarget(self, action: #selector(signinPressed(sender:)), for: .touchUpInside)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 100)
        ])
        
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            signUpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 27)
        ])
        
//        signUpButton.applyTextTheme(withScheme: MDCContainerScheme.init())
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.leftAnchor.constraint(equalTo: signUpLabel.rightAnchor, constant: 5),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
        signUpButton.addTarget(self, action: #selector(signUpPressed(sender:)), for: .touchUpInside)
        
       }
}


//MARK: SignInViewController facebook LoginButtonDelegate
extension SignInViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("loged out")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completionHandler: { connection, result, error in
            print("☢️\(String(describing: result))")
            if (result != nil) {
                self.performSegue(withIdentifier: Constants.Segue.signInCompleted, sender: self)
            }
            
        })
    }
}
