//
//  RegisterViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 01/10/20.
//

import UIKit
import CoreLocation

class RegisterViewController: UIViewController, CustomSegmentedControlDelegate, UITextFieldDelegate {
  
    @IBOutlet weak var physicalConteiner: UIView!
    @IBOutlet weak var digitalConteiner: UIView!
    @IBOutlet weak var bothConteiner: UIView!
    @IBOutlet weak var brandName: UITextField!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var businessTypeLabel: UILabel!
        
    var userName: String?
    var userEmail: String?
    var userBusinessPlacemarkName: String?
    var userBusinessCoordinate: CLLocationCoordinate2D?
    
    func change(to value: Int) {
        
        switch value {
        
        case 0:
            physicalConteiner.isHidden = false
            digitalConteiner.isHidden = true
            bothConteiner.isHidden = true
            setCurrentSegmentedIndexOnRegister(0)
        case 1:
            physicalConteiner.isHidden = true
            digitalConteiner.isHidden = false
            bothConteiner.isHidden = true
            setCurrentSegmentedIndexOnRegister(1)
        case 2:
            physicalConteiner.isHidden = true
            digitalConteiner.isHidden = true
            bothConteiner.isHidden = false
            setCurrentSegmentedIndexOnRegister(2)
        default:
            break
        }
    }
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: [Translation.segmentedControl.physical,Translation.segmentedControl.digital,Translation.segmentedControl.both])
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerLabel.text = Translation.Info.register
        companyLabel.text = Translation.Info.company
        businessTypeLabel.text = Translation.Info.businessType
        brandName.placeholder = Translation.Placeholder.brandName
        
        acessibilityApple()
        
//        change(to: getCurrentSegmentedIndexOnRegister())
        
        self.hideKeyboardWhenTappedAround()
        interfaceSegmented.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func brandNameDidEndEditing(_ sender: UITextField) {
        if let brandName = sender.text {
            userName = brandName
        } else {
            userName = nil
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "physicalContainerSegue" {
            let physicalSVC = segue.destination as! PhysicalSegmentedViewController
            physicalSVC.registerViewController = self
        } else if segue.identifier == "digitalContainerSegue" {
            let digitalSVC = segue.destination as! DigitalSegmentedViewController
            digitalSVC.registerViewController = self
        } else if segue.identifier == "bothContainerSegue" {
            let bothSVC = segue.destination as! BothSegmentedViewController
            bothSVC.registerViewController = self
        } else if segue.identifier == "goToMapVC"{
            let mapVC = segue.destination as! MapViewController
            
            mapVC.callBack = { coordinate in
                self.userBusinessCoordinate = coordinate
                decryptGeoLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemark in
                    self.userBusinessPlacemarkName = placemark
                }
            }
        }
    }
    
    public func showMapView(){
        self.view.endEditing(true)
        performSegue(withIdentifier: "goToMapVC", sender: self)
    }
    
    func sendUserToTabBarController(){
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.performSegue(withIdentifier: "sendUserToTabBarController", sender: self)
        }
    }
    
    public func acessibilityApple(){
        brandName.font = .preferredFont(forTextStyle: .body)
        brandName.accessibilityTraits = .button
        companyLabel.adjustsFontForContentSizeCategory = true
        registerLabel.adjustsFontForContentSizeCategory = true
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

