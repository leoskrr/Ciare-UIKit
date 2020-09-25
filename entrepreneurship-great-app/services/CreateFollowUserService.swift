//
//  CreateFollowUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 25/09/20.
//

import Foundation
import UIKit

enum CreateFollowUserServiceError: Error {
    case loggedUserNotExists
    case followedUserNotExists
}

class CreateFollowUserService {
    
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(loggedUserId: String, followedUserId: String) throws -> [String: User?]{
        guard let loggedUser = usersRepository.findUserById(loggedUserId) else { throw CreateFollowUserServiceError.loggedUserNotExists }
        guard let followedUser = usersRepository.findUserById(followedUserId) else { throw CreateFollowUserServiceError.followedUserNotExists }
        
        let updatedLoggedUser = usersRepository.updateUser(loggedUser)
        let updatedFollowedUser = usersRepository.updateUser(followedUser)
        
        return [
            "loggedUser": updatedLoggedUser,
            "followedUser": updatedFollowedUser
        ]
    }
}
