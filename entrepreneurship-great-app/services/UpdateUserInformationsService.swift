//
//  UpdateUserInformationsService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 09/10/20.
//

import Foundation

enum UpdateUserInformationsServiceResult {
    case success, failed
}

class UpdateUserInformationsService {
    var usersRepository: UsersRepository
    
    init(){
        self.usersRepository = UsersRepository()
    }
    
    public func execute(userInfo: UserInfo, completionHandler: @escaping (UpdateUserInformationsServiceResult, UserInfo?, Error?) -> ()){
        usersRepository.updateUserInformations(newInformations: userInfo){
            user, error in
            
            guard let updatedUserInfo = user, error == nil else {
                completionHandler(.failed, nil, error)
                return
            }
            
            completionHandler(.success, updatedUserInfo, error)
        }
    }
}
