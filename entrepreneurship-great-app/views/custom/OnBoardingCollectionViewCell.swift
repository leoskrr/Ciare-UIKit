//
//  OnBoardingCollectionViewCell.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 22/10/20.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func fillCell(image: UIImage?, title: String, description: String){
        
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
        
    }
    
}
