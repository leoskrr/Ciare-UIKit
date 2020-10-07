//
//  SearchUserTableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 23/09/20.
//

import UIKit

class SearchUserTableViewCell: UITableViewCell {

    var userId: String?
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

    func fillCellData(_ user: User) {
        self.userId = user.id
        self.nameUser.text = user.name
        self.picture.image = user.picture
        self.niche.text = user.areasExpertise?[0] ?? ""
    }
    
    func acessibilityApple(){
        picture.isAccessibilityElement = true
        picture.accessibilityTraits = .image
        picture.accessibilityLabel = "perfil"
    }
}
