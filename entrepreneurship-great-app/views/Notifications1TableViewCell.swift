//
//  Notifications1TableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 13/10/20.
//

import UIKit
import CloudKit.CKRecord

class Notifications1TableViewCell: UITableViewCell {

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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCellWith(userInfoId: CKRecord.ID){
        partnershipRequestText.text = Translation.Notification.newPartnershipRequest
        acceptButton.setTitle(Translation.Notification.accept, for: .normal)
        refuseButton.setTitle(Translation.Notification.delete, for: .normal)

        loadUserData(userId: userInfoId)
    }
    
    @IBAction func acceptButtonSelected(_ sender: UIButton) {
    }
    @IBAction func refuseButtonSelected(_ sender: Any) {
    }
    
}
