//
//  SpinnerViewController.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 26/10/20.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)

    var currentTheme: UIUserInterfaceStyle = .light {
        didSet{
            if currentTheme == .dark {
                view.backgroundColor = UIColor(white: 0, alpha: 0.7)
            } else {
                view.backgroundColor = UIColor(white: 1, alpha: 0.7)
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        currentTheme = self.traitCollection.userInterfaceStyle
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        currentTheme = newCollection.userInterfaceStyle
    }
    
    override func viewDidLoad() {        
        currentTheme = self.traitCollection.userInterfaceStyle

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        super.viewDidLoad()
    }
}
