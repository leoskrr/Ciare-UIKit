//
//  Notifications1TableViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 13/10/20.
//

import UIKit

class Notifications1TableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var refuseButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func acceptButtonSelected(_ sender: UIButton) {
    }
    @IBAction func refuseButtonSelected(_ sender: Any) {
    }
    
}
