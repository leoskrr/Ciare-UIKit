//
//  UsersRepository.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 24/09/20.
//

import Foundation
import UIKit

class UsersRepository{
    let users = User.all
    
    public func findUserById(_ id: String) -> User? {
        if let user = users.first(where: { $0.id == id }) {
            return user
        }
        return nil
    }
}
