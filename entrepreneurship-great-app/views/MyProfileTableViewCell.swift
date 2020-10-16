//
//  MyProfileTableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 12/10/20.
//

import UIKit
import CloudKit.CKRecord

class MyProfileTableViewCell: UITableViewCell {

    var postId: CKRecord.ID!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var textViewHC: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCellData(_ post: Post,_ user: UserInfo){
        self.companyNameLabel.text = user.name
        self.postDescription.text = post.description
        self.timeStampLabel.text = ""
        
        if let userPicture = user.picture{
            if let userPictureUrl = userPicture.fileURL {
                self.profileImage.image = UIImage(contentsOfFile: userPictureUrl.path)
            } else {
                self.profileImage.image = UIImage(named: "defaultUserProfileImage")
            }
        } else {
            self.profileImage.image = UIImage(named: "defaultUserProfileImage")
        }
        
        if let postImgUrl = post.image.fileURL {
            self.postImage.image = UIImage(contentsOfFile: postImgUrl.path)
        }
    }
    
    func fillWithLoadingData(){
        self.companyNameLabel.text = Translation.Load.loadingText
        self.postDescription.text = Translation.Load.loadingText
        self.timeStampLabel.text = ""
    }
    
    func adjustUITextViewHeight(textView: UITextView){
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.sizeToFit()
        textView.isScrollEnabled = false
    
    }
}
