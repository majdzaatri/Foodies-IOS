//
//  VC2.swift
//  Foodies
//
//  Created by Majd Zaatri on 20/04/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController  {
      @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 25
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 2, height: 5)
        signUpButton.layer.shadowRadius = 5
        signUpButton.layer.shadowOpacity = 1.0
         
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "F O O D I E S"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
