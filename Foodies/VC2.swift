//
//  VC2.swift
//  Foodies
//
//  Created by Majd Zaatri on 20/04/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit

class VC2: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
