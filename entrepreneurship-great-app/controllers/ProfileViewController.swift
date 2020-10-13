//
//  ProfileViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 12/10/20.
//

import UIKit
import CloudKit.CKRecord

class ProfileViewController: UIViewController, CustomSegmentedControlDelegate {
   
    

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicheLabel: UILabel!
    
    
    
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var partnershipsQuantity: UILabel!
    @IBOutlet weak var followingQuantity: UILabel!
    @IBOutlet weak var followersQuantity: UILabel!
    
    
    
    
    @IBOutlet weak var myContainer: UIView!
    @IBOutlet weak var midiaKitContainer: UIView!
    @IBOutlet weak var moodBoardContainer: UIView!
    
    
    func change(to index: Int) {
        
        print(index)
        
        switch index {
        
        case 0:
            myContainer.isHidden = false
            midiaKitContainer.isHidden = true
            moodBoardContainer.isHidden = true
            print(index)
        case 1:
            myContainer.isHidden = true
            midiaKitContainer.isHidden = false
            moodBoardContainer.isHidden = true
            print(index)
        case 2:
            midiaKitContainer.isHidden = true
            myContainer.isHidden = true
            moodBoardContainer.isHidden = false
            print(index)
        default:
            break
        }
    }
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: [Translation.Info.my,"MidiaKit","MoodBoard"])
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        change(to: 0)
        
        interfaceSegmented.delegate = self


        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func followButtonSelected(_ sender: UIButton) {
        
//        if sender.titleLabel?.text == Translation.Placeholder.btnFollow{
//            followUserAction()
//            drawAskPartnershipButton(sender)
//        } else if sender.titleLabel?.text == Translation.Placeholder.askPartnership{
//            askPartnershipAction()
//        } else if sender.titleLabel?.text == Translation.Placeholder.askedPartnership {
//            //cancel partnership
//            drawAskPartnershipButton(sender)
//        }
    }
    
    

}
