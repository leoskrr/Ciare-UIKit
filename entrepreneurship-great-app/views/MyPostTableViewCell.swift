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
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionPost: UITextView!
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func fillCellData(_ post: Post){
        
//        self.postId = post.id
//        self.companyNameLabel.text = post.author_id
//
//        if let postAsset = post.image
//
//
    }

}
