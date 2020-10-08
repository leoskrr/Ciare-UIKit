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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        
        assecibilityApple()
    }
    
    @IBAction func finishSelected(_ sender: UIButton) {
        guard let name = registerViewController!.brandName.text else {
            return
        }
        
        guard let businessArea = businessAreaTextField.text else {
            return
        }
        
        let userInfo = UserInfo(name: name)
        userInfo.expertiseAreas = businessArea.components(separatedBy: " ")
        userInfo.typeBusiness = "Physical"
        
        if let coreLocation = registerViewController!.userBusinessCoordinate {
            userInfo.location = CLLocation(latitude: coreLocation.latitude, longitude: coreLocation.longitude)
        }
        
        SignUpUserService().execute(userInfo) {
            signUpResult, error in
            
            switch signUpResult {
            case .success:
                print("sucesso ao cadastrar!")
            case .fail:
                print("erro ao cadastrar: \(error!)")
            }
        }
    }
    
    func assecibilityApple(){
        finishButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}

extension PhysicalSegmentedViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        registerViewController?.showMapView()
    }
}
