//
//  ListAllUsersService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 07/10/20.
//

import Foundation

class ListAllUsersService {
    
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(completionHandler: @escaping ([UserInfo]?, Error?) -> ()){
        usersRepository.listAllUsers(){
            result, error in
            
            guard let users = result, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(users, nil)
        }
    }
}
