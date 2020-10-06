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
    
    var userName: String?
    var userEmail: String?
    var userBusinessCoordinate: CLLocationCoordinate2D?
    
    func change(to index: Int) {
        
        switch index {
        
        case 0:
            physicalConteiner.isHidden = false
            digitalConteiner.isHidden = true
            bothConteiner.isHidden = true
        case 1:
            physicalConteiner.isHidden = true
            digitalConteiner.isHidden = false
            bothConteiner.isHidden = true
        case 2:
            physicalConteiner.isHidden = true
            digitalConteiner.isHidden = true
            bothConteiner.isHidden = false
        default:
            break
        }
    }
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Physical","Digital","Both"])
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        change(to: 0)
        self.hideKeyboardWhenTappedAround()
        interfaceSegmented.delegate = self
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
        } else if segue.identifier == "goToMapVC"{
            let mapVC = segue.destination as! MapViewController
            mapVC.callBack = { coordinate in
                self.userBusinessCoordinate = coordinate
            }
        }
    }
    
    public func showMapView(){
        performSegue(withIdentifier: "goToMapVC", sender: self)
        self.view.endEditing(true)
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
