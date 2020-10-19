//
//  UIImage+Extension.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 10/10/20.
//  Special thanks to user4261201 (stackexchange.com/users/5345534/user4261201)

import Foundation
import UIKit

extension UIImage {
    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newHeightImage = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeightImage))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeightImage))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
