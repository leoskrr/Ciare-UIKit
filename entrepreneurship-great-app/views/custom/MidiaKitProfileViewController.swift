//
//  MidiaKitProfileViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 12/10/20.
//

import UIKit

class MidiaKitProfileViewController: UIViewController {

    
    @IBOutlet weak var soonLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        soonLabel.text = Translation.segmentedControl.soonMidiaKit
    }

}
