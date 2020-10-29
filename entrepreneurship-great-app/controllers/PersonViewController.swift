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
    
    var shouldBackToSearch = true
    
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
    
    @IBOutlet weak var postsContainer: UIView!
    @IBOutlet weak var MidiaKitConteiner: UIView!
    @IBOutlet weak var MoodBoardConteiner: UIView!
    
    
    func change(to index: Int) {
        
        switch index {
        
        case 0:
            postsContainer.isHidden = false
            MidiaKitConteiner.isHidden = true
            MoodBoardConteiner.isHidden = true
        case 1:
            MidiaKitConteiner.isHidden = false
            postsContainer.isHidden = true
            MoodBoardConteiner.isHidden = true
        case 2:
            MidiaKitConteiner.isHidden = true
            postsContainer.isHidden = true
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
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            
            self.loadDynamicData(personProfile: personProfile)
        }
    }
    
    func loadDynamicData(personProfile: UserInfo){
        let person = personProfile
        
        DispatchQueue.main.async {
            if let userAsset = person.picture {
                if let imageUrl = userAsset.fileURL{
                    self.profileImage.image = UIImage(contentsOfFile: imageUrl.path)
                }
            } else {
                self.profileImage.image = UIImage(named: "defaultUserProfileImage")
            }
            self.name.text = person.name
            self.niche.text = person.expertiseAreas?[0] ?? ""
            self.partnershipsQuantity.text = "0"
            self.followingQuantity.text = "0"
            self.followersQuantity.text = "\(person.followers?.count ?? 0)"
            self.profileImage.isHidden = false
        }
        
        shouldShowFollowButton(personToFollow: person)
    }
    
    func shouldShowFollowButton(personToFollow person: UserInfo){
        if person.recordID!.recordName == getUserInfoRecordNameFromUserDefaults()! {
            DispatchQueue.main.async {
                self.drawYourProfileButton(self.followButton)
            }
        } else {
            ListUserInformationService().execute(){
                loggedUser, error in
                
                guard let user = loggedUser, error == nil else {
                    DispatchQueue.main.async {
                        showAlertError(self, text: Translation.Error.server)
                    }
                    return
                }
                
                guard let userFollowing = user.following else {
                    DispatchQueue.main.async {
                        showAlertError(self, text: Translation.Error.server)
                    }
                    return
                }
                
                if userFollowing.contains(CKRecord.Reference(recordID: person.recordID!, action: .none)) {
                    DispatchQueue.main.async {
                        self.shouldShowAskPartnershipButton(loggedUser: user, person: person)
                        self.followButton.isEnabled = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.drawFollowButton(self.followButton)
                        self.followButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    func shouldShowAskPartnershipButton(loggedUser: UserInfo, person: UserInfo){
        if loggedUser.partners!.contains(CKRecord.Reference(recordID: person.recordID!, action: .none)){
            DispatchQueue.main.async {
                self.drawPartnersButton(self.followButton)
            }
        } else {
            ListOneAskPartnershipService().execute(by: loggedUser.recordID!, to: person.recordID!){
                
                _, error in
                
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.drawAskPartnershipButton(self.followButton)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.drawAskedPartnershipButton(self.followButton)
                }
            }
        }
    }
    
    @IBAction func followButtonSelected(_ sender: UIButton) {
        
        if sender.titleLabel?.text == Translation.Placeholder.btnFollow{
            followUserAction()
            drawAskPartnershipButton(sender)
        } else if sender.titleLabel?.text == Translation.Placeholder.askPartnership{
            askPartnershipAction()
        } else if sender.titleLabel?.text == Translation.Placeholder.askedPartnership {
            //cancel partnership
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
    
    func drawPartnersButton(_ sender: UIButton){
        sender.setTitle(Translation.Info.partners, for: .normal)
        sender.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.3058823529, blue: 0.6941176471, alpha: 1)
        sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    func drawYourProfileButton(_ sender: UIButton){
        sender.isEnabled = false
        sender.setTitle(Translation.Placeholder.youText, for: .normal)
        sender.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.3058823529, blue: 0.6941176471, alpha: 1)
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
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            
            ListInfoByIdService().execute(recordId: self.person!.recordID!) {
                followed, error in
                
                guard let followedUser = followed, error == nil else {
                    DispatchQueue.main.async {
                        showAlertError(self, text: Translation.Error.server)
                    }
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
    
    func askPartnershipAction(){
        guard let loggedUserInfoRN = getUserInfoRecordNameFromUserDefaults() else {
            return
        }
        
        let loggedUserInfoId = CKRecord.ID(recordName: loggedUserInfoRN)
        let askedUserInfoId = person!.recordID
        
        CreateAskPartnershipService().execute(by: loggedUserInfoId, to: askedUserInfoId!){
            _, _, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.drawAskedPartnershipButton(self.followButton)
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
            
            guard let _ = infos, error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
        }
    }
    
    @IBAction func backToSearchView(_ sender: Any) {
        
        if shouldBackToSearch {
            let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
            
            self.definesPresentationContext = true
            
            searchVC.modalPresentationStyle = .overCurrentContext
            self.present(searchVC, animated: false, completion: nil)
        } else {
            let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedView") as! FeedViewController
            
            self.definesPresentationContext = true
            
            searchVC.modalPresentationStyle = .overCurrentContext
            self.present(searchVC, animated: false, completion: nil)
        }
        
        
    }
    
    @IBAction func actionViewButton(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: Translation.Alert.title, message: Translation.Alert.subtitle, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Translation.Util.cancel, style: .cancel, handler: nil))
        
//        actionSheet.addAction(UIAlertAction(title: Translation.Alert.message, style: .default, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.unfollow, style: .default, handler: {_ in
            self.followButton.setTitle(Translation.Placeholder.btnFollow, for: .normal)
            self.followButton.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            self.followButton.layer.borderWidth = 0
            self.followButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }))
        
//        actionSheet.addAction(UIAlertAction(title: Translation.Alert.blockUser, style: .destructive, handler: nil))
        
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
        profileImage.isHidden = true
        interfaceSegmented.delegate = self
        
        followButton.setTitle(Translation.Placeholder.btnFollow, for: .normal)
        followButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        partnersLabel.text = Translation.Info.partners
        followingLabel.text = Translation.Info.following
        followersLabel.text = Translation.Info.followers
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawLoadFollowButton()
        loadPersonData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "personPostsContainer" {
            let personPostsContainer = segue.destination as! MyCustomViewController
            personPostsContainer.personViewController = self
        }
    }
}
