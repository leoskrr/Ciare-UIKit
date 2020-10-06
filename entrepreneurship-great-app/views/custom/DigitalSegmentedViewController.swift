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
    @IBOutlet weak var finishButton: UIButton!
    
    
    var selected1 = false
    var selected2 = false
    var selected3 = false
    var selected4 = false
    var selected5 = false
    var selected6 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        asseecibilityApple()
        
    }
    
    @IBAction func instagramSelected(_ sender: UIButton) {
        if selected1 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            selected1 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            selected1 = false
        }
        
    }
    @IBAction func facebookSelected(_ sender: UIButton) {
        if selected2 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            selected2 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            selected2 = false
        }
    }
    @IBAction func twitterSelected(_ sender: UIButton) {
        if selected3 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            selected3 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            selected3 = false
        }
    }
    @IBAction func linkedinSelected(_ sender: UIButton) {
        if selected4 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            selected4 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            selected4 = false
        }
    }
    @IBAction func tiktokSelected(_ sender: UIButton) {
        if selected5 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            selected5 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            selected5 = false
        }
    }
    @IBAction func whatsappSelected(_ sender: UIButton) {
        if selected6 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            selected6 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            selected6 = false
        }
    }
    
    func asseecibilityApple(){
        instagramButton.titleLabel?.adjustsFontForContentSizeCategory = true
        facebookButton.titleLabel?.adjustsFontForContentSizeCategory = true
        twitterButton.titleLabel?.adjustsFontForContentSizeCategory = true
        linkedinButton.titleLabel?.adjustsFontForContentSizeCategory = true
        tiktokButton.titleLabel?.adjustsFontForContentSizeCategory = true
        whatsappButton.titleLabel?.adjustsFontForContentSizeCategory = true
        finishButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    @IBAction func finishSelected(_ sender: UIButton) {
    }
    
}
