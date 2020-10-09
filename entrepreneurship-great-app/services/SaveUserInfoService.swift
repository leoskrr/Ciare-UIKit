//
//  SaveUserInfoService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 09/10/20.
//

import Foundation

enum SaveUserInfoServiceResult {
    case success, failed
}

class SaveUserInfoService {
    var usersRepository: UsersRepository
    
    init(){
        self.usersRepository = UsersRepository()
    }
    
    public func execute(userInfo: UserInfo, completionHandler: @escaping (SaveUserInfoServiceResult, UserInfo?, Error?) -> ()){
        usersRepository.saveUserInfo(userInfo: userInfo){
            user, error in
            
            guard let savedUserInfo = user, error == nil else {
                completionHandler(.failed, nil, error)
                return
            }
            
            completionHandler(.success, savedUserInfo, error)
        }
    }
}
