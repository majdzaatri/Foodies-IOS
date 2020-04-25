//
//  MaterialComponents.swift
//  Foodies
//
//  Created by Majd Zaatri on 25/04/2020.
//  Copyright © 2020 Majd Zaatri. All rights reserved.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialButtons_Theming

struct MaterialComponentsStruct {
    
    struct TextField{
        var labelText: String
        var placeHolder: String
        var alpha: CGFloat?
        var isSecure: Bool
        
        init(_ labelText: String, _ placeHolder: String, _ alpha: CGFloat?, _ isSecure: Bool) {
            self.labelText = labelText
            self.placeHolder = placeHolder
            self.alpha = alpha
            self.isSecure = isSecure
        }
        
        func initTextField() -> MDCFilledTextField {
            
            let textField = MDCFilledTextField()
            textField.label.text = self.labelText
            textField.placeholder = self.placeHolder
            if let alphaSize = self.alpha {
                textField.alpha = alphaSize
            }
            textField.isSecureTextEntry = self.isSecure
            return textField
        }
        
        
    }
}
