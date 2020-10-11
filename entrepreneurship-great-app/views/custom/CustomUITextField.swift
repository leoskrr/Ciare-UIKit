//
//  CustomUITextField.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 11/10/20.
//

import Foundation
import UIKit

@IBDesignable class CustomUITextField: UITextField {
    
    @IBInspectable var leftPadding: CGFloat = 15{
        didSet{
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    @IBInspectable var roundTextField: Bool = true{
        didSet{
            if roundTextField {
                self.layer.cornerRadius = 15
                self.layer.borderWidth = 1.0
                self.layer.masksToBounds = true
            } else {
                self.layer.cornerRadius = 0
                self.layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.lightGray{
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        borderColor = UIColor(named: "inputFieldColor")!
    }
}
