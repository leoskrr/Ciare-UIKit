//
//  SignInUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 01/10/20.
//

import Foundation
import CloudKit

enum SignInUserServiceResult {
    case SendUserToRegister
    case SendUserToFeed
    case Error
}

class SignInUserService {
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(completionHandler: @escaping (SignInUserServiceResult, CKRecord?, Error?) -> ()){
        CKContainer.default().fetchUserRecordID {
            recordID, error in
            
            guard let recordID = recordID, error == nil else {
                return
            }
            
            self.usersRepository.fetchOneUser(withRecordID: recordID){
                result, record, error in
                switch result {
                    case .Successed:
                        let userName = record!["name"] as! String?
                        
                        if userName != nil && !userName!.isEmpty {
                            completionHandler(.SendUserToFeed, record, nil)
                            let userInfoReference = record!["informations"] as! CKRecord.Reference
                            storeUserInfoRecordNameInUserDefaults(userInfoReference)
                        } else {
                            print("entra aq")
                            completionHandler(.SendUserToRegister, record, nil)
                        }
                        storeUserRecordNameInUserDefaults(recordID)
                    case .Failed:
                        completionHandler(.Error, nil, error)
                }
            }
        }
    }
}
