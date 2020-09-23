//
//  SearchUserTableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 23/09/20.
//

import UIKit

class SearchUserTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var niche: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        

        // Configure the view for the selected state
    }

    func fillCellData(_ user: User) {
        
        self.nameUser.text = user.name
        self.picture.image = user.picture
        self.niche.text = user.areasExpertise?[0] ?? ""
        
        
    }

}
