//
//  ListAllUsersByCharactersService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 07/10/20.
//

import Foundation

class ListAllUsersByCharactersService {
    
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(characters: String, completionHandler: @escaping ([UserInfo]?, Error?) -> ()){
                
        let chars = characters.first?.uppercased() ?? "" + characters.dropFirst().localizedLowercase
        
        usersRepository.listAllUsersByNameContaining(chars){
            result, error in
                        
            guard let users = result, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(users, nil)
        }
    }
}
