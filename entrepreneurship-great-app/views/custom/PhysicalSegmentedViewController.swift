//
//  PhysicalSegmentedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 02/10/20.
//

import UIKit
import CoreLocation

class PhysicalSegmentedViewController: UIViewController {
    
    @IBOutlet weak var businessAreaTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    
    var brandName: String?
    var registerViewController: RegisterViewController?
    //var mapViewController: MapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
    }
    
    @IBAction func finishSelected(_ sender: UIButton) {
        
        guard let name = registerViewController!.brandName.text else {
            return
        }
        
        if let coreLocation = registerViewController!.userBusinessCoordinate {
            SignUpUserService().execute(name: name, location: CLLocation(latitude: coreLocation.latitude, longitude: coreLocation.longitude))
        } else {
            SignUpUserService().execute(name: name, location: nil)
        }

    }
    
}

extension PhysicalSegmentedViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        registerViewController?.showMapView()
    }
}
