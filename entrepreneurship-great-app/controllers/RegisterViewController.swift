//
//  RegisterViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 01/10/20.
//

import UIKit

class RegisterViewController: UIViewController, CustomSegmentedControlDelegate, UITextFieldDelegate {
  
    @IBOutlet weak var physicalConteiner: UIView!
    @IBOutlet weak var digitalConteiner: UIView!
    
    func change(to index: Int) {
        
        switch index {
        
        case 0:
            physicalConteiner.isHidden = false
            digitalConteiner.isHidden = true
            
            
            
//            let BusinessAreaTextField =  UITextField()
//            BusinessAreaTextField.placeholder = "Business Area"
//            BusinessAreaTextField.font = UIFont.systemFont(ofSize: 15)
//            BusinessAreaTextField.borderStyle = UITextField.BorderStyle.roundedRect
//            view.addSubview(BusinessAreaTextField)
//
//            BusinessAreaTextField.translatesAutoresizingMaskIntoConstraints = false
//
//            let leadingConstraint = NSLayoutConstraint(item: BusinessAreaTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16)
//            let trailingConstraint = NSLayoutConstraint(item: BusinessAreaTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16)
//            let topConstraint = NSLayoutConstraint(item: BusinessAreaTextField, attribute: .top, relatedBy: .equal, toItem: interfaceSegmented, attribute: .bottom, multiplier: 1, constant: 20)
//            BusinessAreaTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//            NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint])
//
//            let locationTextField =  UITextField()
//            locationTextField.placeholder = "Location"
//            locationTextField.font = UIFont.systemFont(ofSize: 15)
//            locationTextField.borderStyle = UITextField.BorderStyle.roundedRect
//            locationTextField.textContentType = .location
//            view.addSubview(locationTextField)
//
//            locationTextField.translatesAutoresizingMaskIntoConstraints = false
//
//            let leadingConstraintLocation = NSLayoutConstraint(item: locationTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16)
//            let trailingConstraintLocation = NSLayoutConstraint(item: locationTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16)
//            let topConstraintLocation = NSLayoutConstraint(item: locationTextField, attribute: .top, relatedBy: .equal, toItem: BusinessAreaTextField, attribute: .bottom, multiplier: 1, constant: 20)
//            locationTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//            NSLayoutConstraint.activate([leadingConstraintLocation, trailingConstraintLocation, topConstraintLocation])
            
//            let BusinessAreaTextField =  UITextField()
//            BusinessAreaTextField.placeholder = "Business Area"
//            BusinessAreaTextField.font = UIFont.systemFont(ofSize: 15)
//            BusinessAreaTextField.borderStyle = UITextField.BorderStyle.roundedRect
//            view.addSubview(BusinessAreaTextField)
//
//            BusinessAreaTextField.translatesAutoresizingMaskIntoConstraints = false
//
//            let leadingConstraint = NSLayoutConstraint(item: BusinessAreaTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16)
//            let trailingConstraint = NSLayoutConstraint(item: BusinessAreaTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16)
//            let topConstraint = NSLayoutConstraint(item: BusinessAreaTextField, attribute: .top, relatedBy: .equal, toItem: interfaceSegmented, attribute: .bottom, multiplier: 1, constant: 20)
//            BusinessAreaTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//            NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint])
        case 1:
            physicalConteiner.isHidden = true
            digitalConteiner.isHidden = false
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
        //BusinessAreaTextField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
