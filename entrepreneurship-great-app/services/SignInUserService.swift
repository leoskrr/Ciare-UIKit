//
//  SignInUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 01/10/20.
//

import Foundation
import CloudKit

class SignInUserService {
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(userId: String){
        usersRepository.fetchUser(userId: userId)
    }
}
