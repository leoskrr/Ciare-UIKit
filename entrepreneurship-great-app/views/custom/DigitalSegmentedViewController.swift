//
//  DigitalSegmentedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 01/10/20.
//

import UIKit

class DigitalSegmentedViewController: UIViewController {

    @IBOutlet weak var plataformsLabel: UILabel!
    @IBOutlet weak var businessAreaTextField: UITextField!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var tiktokButton: UIButton!
    @IBOutlet weak var whatsappButton: UIButton!
    
    
    var selected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        print(sender.currentTitle!)
        
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
