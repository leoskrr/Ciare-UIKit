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
    
    var userInformations: UserInfo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func fillCellData(_ post: Post, _ user: UserInfo){
        //User
        self.companyNameLabel.text = user.name
        self.userInformations = user
        
        if let userPicture = user.picture{
            if let userPictureUrl = userPicture.fileURL {
                self.profileImage.image = UIImage(contentsOfFile: userPictureUrl.path)
            } else {
                self.profileImage.image = UIImage(named: "defaultUserProfileImage")
            }
        } else {
            self.profileImage.image = UIImage(named: "defaultUserProfileImage")
        }
        //Post
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
