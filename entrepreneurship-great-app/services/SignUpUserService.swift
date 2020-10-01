//
//  SignUpUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 30/09/20.
//

import Foundation
import CloudKit

enum SignUpUserServiceError: Error {
    case unespecifiedName
}

class SignUpUserService {
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(userId: String, name: String?, email: String) throws{
        if let userName = name {
            usersRepository.saveUser(userId: userId, name: userName, email: email)
        } else {
            throw SignUpUserServiceError.unespecifiedName
        }
    }
}
