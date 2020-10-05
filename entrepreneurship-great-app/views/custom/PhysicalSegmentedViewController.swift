//
//  PhysicalSegmentedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 02/10/20.
//

import UIKit

class PhysicalSegmentedViewController: UIViewController {
    
    @IBOutlet weak var businessAreaTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    
    var brandName: String?
    var registerViewController: RegisterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishSelected(_ sender: UIButton) {
        if let name = registerViewController!.brandName.text {
            print(name)
            
            SignUpUserService().execute(name: name)
            
        } else {
            print("Erro")
        }
//        let registerVC = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterViewController
//
//        print(registerVC.userName as! String)
    
    }
    
}
