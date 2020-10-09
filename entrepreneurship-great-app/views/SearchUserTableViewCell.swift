//
//  SearchUserTableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 23/09/20.
//

import UIKit
import CloudKit

class SearchUserTableViewCell: UITableViewCell {

    var userInfoId: CKRecord.ID!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var niche: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        acessibilityApple()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func fillCellData(_ user: UserInfo) {
        self.userInfoId = user.recordID!
        self.nameUser.text = user.name
        
        if let userAsset = user.picture {
            if let imageUrl = userAsset.fileURL{
                if let imageData = NSData(contentsOf: imageUrl){
                    self.picture.image = UIImage(data: imageData as Data)
                }
            }
        } else {
            self.picture.image = UIImage(named: "img3")
        }
        
        self.niche.text = user.expertiseAreas?[0] ?? ""
    }
    
    func acessibilityApple(){
        
        if let picture = picture {
            picture.isAccessibilityElement = true
            picture.accessibilityTraits = .image
            picture.accessibilityLabel = "perfil"
        }
    }
}
