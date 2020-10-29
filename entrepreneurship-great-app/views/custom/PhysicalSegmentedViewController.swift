//
//  PhysicalSegmentedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 02/10/20.
//

import UIKit
import CoreLocation

class PhysicalSegmentedViewController: UIViewController {
    
    var brandName: String?
    var registerViewController: RegisterViewController?
    
    @IBOutlet weak var businessAreaTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zipCodeTextField.placeholder = Translation.segmentedControl.zipCode
        cityNameTextField.placeholder = Translation.segmentedControl.city
        streetTextField.placeholder = Translation.segmentedControl.street
        businessAreaTextField.placeholder = Translation.segmentedControl.businessArea

        finishButton.setTitle(Translation.segmentedControl.finish, for: .normal)
        
        assecibilityApple()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let userLocation = registerViewController!.userBusinessPlacemarkName {
            streetTextField.text = userLocation
        }
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

        
        if let street = streetTextField.text,
           let city = cityNameTextField.text,
           let zipCode = zipCodeTextField.text {
            
            userInfo.location = street + "," + city + "," + zipCode
        }
                
        SignUpUserService().execute(userInfo) {
            signUpResult, error in
            
            switch signUpResult {
            case .success:
                self.registerViewController!.sendUserToTabBarController()
            case .fail:
                print("erro ao cadastrar: \(error!)")
            }
        }
    }
    
    func assecibilityApple(){
        finishButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}


