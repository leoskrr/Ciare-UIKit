//
//  showAlertError.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 13/10/20.
//

import Foundation
import UIKit

public func showAlertError(_ view: UIViewController, text: String){
    let alert = UIAlertController(title: Translation.Error.errorTitle, message: text, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Translation.Error.closeButton, style: .default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}

public func showSuccessAlert(_ view: UIViewController, text: String){
    let alert = UIAlertController(title: Translation.Success.successTitle, message: text, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Translation.Error.closeButton, style: .default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}
