//
//  MyPostTableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 09/10/20.
//

import UIKit
import CloudKit

class MyPostTableViewCell: UITableViewCell {

    var postId: CKRecord.ID!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionPost: UITextView!
    @IBOutlet weak var textViewHC: NSLayoutConstraint!
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    var userInformations: UserInfo? {
        didSet {
            DispatchQueue.main.async {
                if self.userInformations !== nil {
                    self.companyNameLabel.text = self.userInformations!.name
                    if let userPicture = self.userInformations!.picture{
                        if let userPictureUrl = userPicture.fileURL {
                            self.profileImage.image = UIImage(contentsOfFile: userPictureUrl.path)
                        } else {
                            self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                        }
                    } else {
                        self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func loadUserData(userId: CKRecord.ID){
        ListInfoByIdService().execute(recordId: userId){
            info, error in
            
            guard let userInfo = info, error == nil else {
                return
            }
            
            self.userInformations = userInfo
        }
    }
    
    func fillCellData(_ post: Post){
        self.companyNameLabel.text = Translation.Load.loadingText
        self.profileImage.image = UIImage(named: "defaultUserProfileImage")

        loadUserData(userId: post.author_id.recordID)
        
        self.descriptionPost.text = post.description
        self.timeStampLabel.text = ""
        
        if let postImgUrl = post.image.fileURL {
            self.postImage.image = UIImage(contentsOfFile: postImgUrl.path)
        }
        
        
    }
    
    
    
    
    func adjustUITextViewHeight(){
        descriptionPost.translatesAutoresizingMaskIntoConstraints = true
        descriptionPost.sizeToFit()
        descriptionPost.isScrollEnabled = false
    }
    
}
