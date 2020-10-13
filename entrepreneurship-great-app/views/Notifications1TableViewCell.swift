//
//  Notifications1TableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 13/10/20.
//

import UIKit
import CloudKit.CKRecord

class Notifications1TableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var refuseButton: UIButton!
    
    var user: UserInfo? {
        didSet {
            self.companyName.text = user?.name
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCellWith(userInfoId: CKRecord.ID){
        loadUserData(userId: userInfoId)
    }
    
    @IBAction func acceptButtonSelected(_ sender: UIButton) {
    }
    @IBAction func refuseButtonSelected(_ sender: Any) {
    }
    
}
