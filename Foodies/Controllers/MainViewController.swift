//
//  MainViewController.swift
//  Foodies
//
//  Created by Majd Zaatri on 14/06/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        LoginManager().logOut()
        print("✅logged out")
    }
}
