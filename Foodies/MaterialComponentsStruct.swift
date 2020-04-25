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
        let labelText: String
        let placeHolder: String
        let alpha: CGFloat?
        let isSecure: Bool
        
        init(_ labelText: String, _ placeHolder: String, _ alpha: CGFloat?, _ isSecure: Bool) {
            self.labelText = labelText
            self.placeHolder = placeHolder
            self.alpha = alpha
            self.isSecure = isSecure
        }
        
        func initTextField() -> MDCOutlinedTextField {
            
            let textField = MDCOutlinedTextField()
            textField.label.text = self.labelText
            textField.placeholder = self.placeHolder
            if let alphaSize = self.alpha {
                textField.alpha = alphaSize
            }
            textField.isSecureTextEntry = self.isSecure
            return textField
        }
    }
    
    struct Button {
        let width: Int
        let height: Int
        let alpha: CGFloat?
        let cornerRadius: CGFloat?
        let title: String
        let controlState: UIControl.State
        let titleFont: UIFont
        let titleColor: UIColor
        let backgroundColor: UIColor
        
        
        init(_ width: Int, _ height: Int, _ alpha: CGFloat?, _ cornerRadius: CGFloat?, _ title: String, _ controlState: UIControl.State, _ titleFont: UIFont, _ titleColor: UIColor, _ backgroundColor: UIColor) {
            self.width = width
            self.height = height
            self.alpha = alpha
            self.cornerRadius = cornerRadius
            self.title = title
            self.controlState = controlState
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.backgroundColor = backgroundColor
        }
        
        func initButton() -> MDCButton {
            
            let button = MDCButton()
            button.minimumSize = CGSize(width: width, height: height)
            if let alphaSize = alpha {
                button.alpha = alphaSize
            }
            if let cornerRadiusSize = cornerRadius {
                button.layer.cornerRadius = cornerRadiusSize
            }
            button.setTitle(title, for: controlState)
//            button.titleLabel?.font = titleFont
            button.setTitleFont(titleFont, for: .normal)
            button.setTitleFont(titleFont, for: .selected)
            button.titleLabel?.textColor = titleColor
            button.setBackgroundColor(backgroundColor)
            
            return button
        }
    }
}
