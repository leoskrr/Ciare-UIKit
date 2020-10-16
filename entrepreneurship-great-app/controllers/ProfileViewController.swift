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
    
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    
    var user: UserInfo! {
        didSet{
            DispatchQueue.main.async {
                self.nameLabel.text = self.user.name
                self.nicheLabel.text = self.user.expertiseAreas?[0] ?? ""
                self.partnershipsQuantity.text = "\(self.user.partners?.count ?? 0)"
                self.followingQuantity.text = "\(self.user.following?.count ?? 0)"
                self.followersQuantity.text = "\(self.user.followers?.count ?? 0)"
                if let userImg = self.user.picture {
                    if let userImgUrl = userImg.fileURL {
                        self.profileImage.image = UIImage(contentsOfFile: userImgUrl.path)
                    } else {
                        self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                    }
                } else {
                    self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                }
            }
        }
    }
    
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
        
        partnerLabel.text = Translation.Info.partners
        followingLabel.text = Translation.Info.following
        followersLabel.text = Translation.Info.followers
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.followButton.isEnabled = false
        self.followButton.setTitle(Translation.Placeholder.youText, for: .normal)
        loadComponents()
    }
    
    func loadComponents(){
        self.nameLabel.text = Translation.Load.loadingText
        self.nicheLabel.text = Translation.Load.loadingText
        self.partnershipsQuantity.text = "0"
        self.followingQuantity.text = "0"
        self.followersQuantity.text = "0"
        
        ListUserInformationService().execute(){
            user, error in
            
            guard let info = user, error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            
            self.user = info
        }
    }
    
    @IBAction func followButtonSelected(_ sender: UIButton) {
        
    }
    
    @IBAction func moreButtonSelected(_ sender: Any) {
        
        let actionSheet = UIAlertController()
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.clean, style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title:Translation.Alert.logOut, style: .destructive, handler: {_ in
            
            setUserLoggedInApplicationStatus(false)
            
            
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "loginView")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: false, completion: nil)
            
            self.tabBarController?.tabBar.isHidden = true
        }))
        
       
        
        present(actionSheet, animated: true)
        
        
        
        
        
    }
    
    
    
}
