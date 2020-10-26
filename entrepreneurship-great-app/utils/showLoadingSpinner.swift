//
//  showLoadingSpinner.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 26/10/20.
//

import Foundation
import UIKit

let spinner = SpinnerViewController()

public func showLoadingOnViewController(_ viewController: UIViewController){
    viewController.addChild(spinner)
    
    spinner.view.frame = viewController.view.frame
    viewController.view.addSubview(spinner.view)
    
    spinner.didMove(toParent: viewController)
}

public func removeLoadingOnViewController(_ viewController: UIViewController){
    spinner.willMove(toParent: nil)
    spinner.view.removeFromSuperview()
    spinner.removeFromParent()
}
