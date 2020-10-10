//
//  PersonViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 24/09/20.
//

import UIKit
import CloudKit.CKRecord

class PersonViewController: UIViewController, CustomSegmentedControlDelegate {
    
    var person: UserInfo?
    var personWithLoadedData: UserInfo?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var niche: UILabel!
    @IBOutlet weak var partnershipsQuantity: UILabel!
    @IBOutlet weak var followingQuantity: UILabel!
    @IBOutlet weak var followersQuantity: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var partnersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var MyConteiner: UIView!
    @IBOutlet weak var MidiaKitConteiner: UIView!
    @IBOutlet weak var MoodBoardConteiner: UIView!
    
    
    func change(to index: Int) {
        
        switch index {
        
        case 0:
            MyConteiner.isHidden = false
            MidiaKitConteiner.isHidden = true
            MoodBoardConteiner.isHidden = true
        case 1:
            MidiaKitConteiner.isHidden = false
            MyConteiner.isHidden = true
            MoodBoardConteiner.isHidden = true
        case 2:
            MidiaKitConteiner.isHidden = true
            MyConteiner.isHidden = true
            MoodBoardConteiner.isHidden = false
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
    
    func loadPersonData(){
        ListInfoByIdService().execute(recordId: self.person!.recordID!) {
            person, error in
            
            guard let personProfile = person, error == nil else {
                print("Erro ao achar informações do usuário seguido:\n\(error!)")
                return
            }
            
            self.loadDynamicData(personProfile: personProfile)
        }
    }
    
    func loadDynamicData(personProfile: UserInfo){
        let person = personProfile
        
        DispatchQueue.main.async {
            if let userPicture = person.picture {
                if let imageData = NSData(contentsOf: userPicture.fileURL!){
                    self.profileImage.image = UIImage(data: imageData as Data)
                }
            }
            
            self.name.text = person.name
            self.niche.text = person.expertiseAreas?[0] ?? ""
            self.partnershipsQuantity.text = "0"
            self.followingQuantity.text = "0"
            self.followersQuantity.text = "\(person.followers?.count ?? 0)"
        }
        
        shouldShowFollowButton(personToFollow: person)
    }
    
    func shouldShowFollowButton(personToFollow person: UserInfo){
        ListUserInformationService().execute(){
            loggedUser, error in
            
            guard let user = loggedUser, error == nil else {
                print("Erro ao achar informações do usuário logado:\n\(error!)")
                return
            }
            
            let userFollowsPerson = user.following?.firstIndex(of: CKRecord.Reference(recordID: person.recordID!, action: .none))
            
            if let _ = userFollowsPerson {
                DispatchQueue.main.async {
                    self.followButton.isEnabled = true
                    self.drawAskPartnershipButton(self.followButton)
                }
            } else {
                DispatchQueue.main.async {
                    self.followButton.isEnabled = true
                    self.drawFollowButton(self.followButton)
                }
            }
        }
    }
    
    @IBAction func followButtonSelected(_ sender: UIButton) {
        
        if sender.titleLabel?.text == Translation.Placeholder.btnFollow{
            followUserAction()
            drawAskPartnershipButton(sender)
        } else if sender.titleLabel?.text == Translation.Placeholder.askPartnership{
            drawAskedPartnershipButton(sender)
        } else if sender.titleLabel?.text == Translation.Placeholder.askedPartnership {
            drawAskPartnershipButton(sender)
        }
    }
    
    func drawLoadFollowButton(){
        followButton.isEnabled = false
        followButton.setTitleColor(.lightGray, for: .normal)
        followButton.setTitle(Translation.Load.loadingText, for: .normal)
    }
    
    func drawFollowButton(_ sender: UIButton){
        sender.setTitle(Translation.Placeholder.btnFollow, for: .normal)
        sender.setTitleColor(.label, for: .normal)
    }
    
    func drawAskPartnershipButton(_ sender: UIButton){
        sender.setTitle(Translation.Placeholder.askPartnership, for: .normal)
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sender.layer.borderColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
        sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        sender.layer.borderWidth = 1
    }
    
    func drawAskedPartnershipButton(_ sender: UIButton){
        sender.setTitle(Translation.Placeholder.askedPartnership, for: .normal)
        sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
        sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    func followUserAction(){
        if let currentTextInLabel = followersQuantity.text {
            followersQuantity.text = "\(Int(currentTextInLabel)! + 1)"
        } else {
            followersQuantity.text = "0"
        }
        
        ListUserInformationService().execute(){
            follower, error in
            
            guard let followerUser = follower, error == nil else {
                print("Erro ao achar informações do usuário logado:\n\(error!)")
                return
            }
            
            ListInfoByIdService().execute(recordId: self.person!.recordID!) {
                followed, error in
                
                guard let followedUser = followed, error == nil else {
                    print("Erro ao achar informações do usuário seguido:\n\(error!)")
                    return
                }
                
                let followedUserRef = CKRecord.Reference(recordID: followedUser.recordID!, action: .none)
                
                let followerUserRef = CKRecord.Reference(recordID: followerUser.recordID!, action: .none)
                
                followerUser.following = self.insertUserInArray(followerUser.following, userRef: followedUserRef)
                
                followedUser.followers = self.insertUserInArray(followedUser.followers, userRef: followerUserRef)
                
                self.updateInformationsOfUser(followerUser)
                self.updateInformationsOfUser(followedUser)
            }
        }
    }
    
    func insertUserInArray(_ array: [CKRecord.Reference]?, userRef: CKRecord.Reference) -> [CKRecord.Reference]?{
        
        var arrayToReturn = array
        
        if arrayToReturn == nil {
            arrayToReturn = [userRef]
        } else {
            arrayToReturn?.append(userRef)
        }
        
        return arrayToReturn
    }
    
    func updateInformationsOfUser(_ user: UserInfo){
        UpdateUserInformationsService().execute(userInfo: user) {
            _, infos, error in
            
            guard let userInfos = infos, error == nil else {
                print("Erro ao salvar usuário \(user.name):\n\(error!)")
                return
            }
            
            print("Usuário \(userInfos.name) atualizado com sucesso!")
        }
    }
    
    @IBAction func backToSearchView(_ sender: Any) {
        
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
        
        self.definesPresentationContext = true
        
        searchVC.modalPresentationStyle = .overCurrentContext
        self.present(searchVC, animated: false, completion: nil)
    }
    
    @IBAction func actionViewButton(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: Translation.Alert.title, message: Translation.Alert.subtitle, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.cancel, style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.message, style: .default, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.unfollow, style: .default, handler: {_ in
            self.followButton.setTitle(Translation.Placeholder.btnFollow, for: .normal)
            self.followButton.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            self.followButton.layer.borderWidth = 0
            self.followButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }))
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.blockUser, style: .destructive, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    func assecibilityApple(){
        followButton.titleLabel?.adjustsFontForContentSizeCategory = true
        profileImage.isAccessibilityElement = true
        profileImage.accessibilityTraits = .image
        profileImage.accessibilityLabel = Translation.Assecibility.profile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assecibilityApple()
        loadPersonData()
        
        interfaceSegmented.delegate = self
        
        followButton.setTitle(Translation.Placeholder.btnFollow, for: .normal)
        partnersLabel.text = Translation.Info.partners
        followingLabel.text = Translation.Info.following
        followersLabel.text = Translation.Info.followers
        
        change(to: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawLoadFollowButton()
        loadPersonData()
    }
}
