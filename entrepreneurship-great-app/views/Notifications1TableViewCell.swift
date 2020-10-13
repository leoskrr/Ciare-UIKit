//
//  Notifications1TableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 13/10/20.
//

import UIKit
import CloudKit.CKRecord

class Notifications1TableViewCell: UITableViewCell {
    
    var notificationId: CKRecord.ID?
    
    @IBOutlet weak var partnershipRequestText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var refuseButton: UIButton!
    
    var user: UserInfo? {
        didSet {
            DispatchQueue.main.async {
                self.companyName.text = self.user?.name
                self.timeStampLabel.text = ""
                self.acceptButton.isHidden = false
                self.refuseButton.isHidden = false
                
                if let userImg = self.user?.picture {
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
    
    func loadUserData(userId: CKRecord.ID){
        ListInfoByIdService().execute(recordId: userId){
            info, error in
            
            guard let user = info, error == nil else {
                return
            }
            
            self.user = user
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        partnershipRequestText.text = Translation.Notification.newPartnershipRequest
        acceptButton.setTitle(Translation.Notification.accept, for: .normal)
        refuseButton.setTitle(Translation.Notification.delete, for: .normal)
        hideButtons()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 7, right: 5))
    }
    
    func hideButtons(){
        
        acceptButton.isHidden = true
        refuseButton.isHidden = true
    }
    
    func fillCellWith(userInfoId: CKRecord.ID, notificationId: CKRecord.ID ){
        loadUserData(userId: userInfoId)
        self.notificationId = notificationId
    }
    
    func createPartnership(){
        let newPartner = user!
        
        ListUserInformationService().execute(){
            user, error in
            
            guard let loggedUser = user, error == nil else {
                return
            }
            
            let loggedUserRef = CKRecord.Reference(recordID: loggedUser.recordID!, action: .none)
            let newPartnerRef = CKRecord.Reference(recordID: newPartner.recordID!, action: .none)
            
            loggedUser.partners = self.insertUserInArray(loggedUser.partners, userRef: newPartnerRef)
            newPartner.partners = self.insertUserInArray(loggedUser.partners, userRef: loggedUserRef)
            
            if !(loggedUser.following?.contains(newPartnerRef))!{
                loggedUser.following?.append(newPartnerRef)
            }
            
            self.updateInformationsOfUser(loggedUser)
            self.updateInformationsOfUser(newPartner)
            DispatchQueue.main.async {
                self.hideButtons()
            }
            DeleteRequestPartnershipService().execute(id: self.notificationId!)
        }
    }
    
    func updateInformationsOfUser(_ user: UserInfo){
        UpdateUserInformationsService().execute(userInfo: user) {
            _, infos, error in
            
            guard let _ = infos, error == nil else {
                return
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
    
    @IBAction func acceptButtonSelected(_ sender: UIButton) {
        createPartnership()
    }
    
    @IBAction func refuseButtonSelected(_ sender: Any) {
        DeleteRequestPartnershipService().execute(id: notificationId!)
        DispatchQueue.main.async {
            self.hideButtons()
        }
    }
}
