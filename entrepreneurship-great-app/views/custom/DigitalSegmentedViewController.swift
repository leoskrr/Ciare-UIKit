//
//  DigitalSegmentedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 01/10/20.
//

import UIKit

class DigitalSegmentedViewController: UIViewController {

    var registerViewController: RegisterViewController?
    
    @IBOutlet weak var plataformsLabel: UILabel!
    @IBOutlet weak var businessAreaTextField: UITextField!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var tiktokButton: UIButton!
    @IBOutlet weak var whatsappButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
        
    var socialNetworks = [String]()
    
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
    
    func appendNetworkInArray(_ network: String) {
        socialNetworks.append(network)
    }
    
    func removeNetworkInArray(_ network: String) {
        let index = socialNetworks.firstIndex(of: network)
        
        if let existentIndex = index {
            socialNetworks.remove(at: existentIndex)
        }
    }

    
    @IBAction func instagramSelected(_ sender: UIButton) {
        if selected1 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            appendNetworkInArray("Instagram")
            selected1 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            removeNetworkInArray("Instagram")
            selected1 = false
        }
        
    }
    @IBAction func facebookSelected(_ sender: UIButton) {
        if selected2 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            appendNetworkInArray("Facebook")
            selected2 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            removeNetworkInArray("Facebook")
            selected2 = false
        }
    }
    @IBAction func twitterSelected(_ sender: UIButton) {
        if selected3 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            appendNetworkInArray("Twitter")
            selected3 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            removeNetworkInArray("Twitter")
            selected3 = false
        }
    }
    @IBAction func linkedinSelected(_ sender: UIButton) {
        if selected4 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            appendNetworkInArray("LinkedIn")
            selected4 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            removeNetworkInArray("LinkedIn")
            selected4 = false
        }
    }
    @IBAction func tiktokSelected(_ sender: UIButton) {
        if selected5 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            appendNetworkInArray("TikTok")
            selected5 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            removeNetworkInArray("TikTok")
            selected5 = false
        }
    }
    @IBAction func whatsappSelected(_ sender: UIButton) {
        if selected6 == false{
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            appendNetworkInArray("Whatsapp")
            selected6 = true
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0.3428003788, green: 0.3428530097, blue: 0.3427838087, alpha: 1), for: .normal)
            removeNetworkInArray("Whatsapp")
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
        guard let name = registerViewController!.brandName.text else {
            return
        }
        
        guard let businessArea = businessAreaTextField.text else {
            return
        }
        
        let userInfo = UserInfo(name: name)
        userInfo.expertiseAreas = businessArea.components(separatedBy: " ")
        userInfo.typeBusiness = "Digital"
        userInfo.socialNetworks = socialNetworks
                
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
    
}
