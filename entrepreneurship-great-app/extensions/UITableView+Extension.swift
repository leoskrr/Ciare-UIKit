//
//  UITableView+Extension.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 14/10/20.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = UIColor(named: "TitleRegister")
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()

            self.backgroundView = messageLabel
            self.separatorStyle = .none
        }

        func restore() {
            self.backgroundView = nil
            self.separatorStyle = .singleLine
        }
}
