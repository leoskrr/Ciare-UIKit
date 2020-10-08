//
//  SignUpUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 30/09/20.
//

import Foundation
import CloudKit
import CoreLocation

enum SignUpUserServiceResult {
    case success, fail
}

class SignUpUserService {
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(_ user: UserInfo, completionHandler: @escaping (SignUpUserServiceResult, Error?)->()){
        CKContainer.default().fetchUserRecordID {
            recordID, error in
            
            guard let recordID = recordID, error == nil else {
                return
            }
            
            self.usersRepository.fetchOneUser(withRecordID: recordID) {
                operationResult, record, error in
                
                switch operationResult {
                case .Successed:
                    
                    let userRecord = record!
                    let userInfosRecord = CKRecord(recordType: "UsersInfos")
                    
                    userRecord["name"] = user.name
                    
                    userInfosRecord["name"] = user.name
                    userInfosRecord["location"] = user.location
                    userInfosRecord["picture"] = user.picture
                    userInfosRecord["availablePartnerships"] = user.availablePartnerships
                    userInfosRecord["typeBusiness"] = user.typeBusiness
                    userInfosRecord["expertiseAreas"] = user.expertiseAreas
                    userInfosRecord["socialNetworks"] = user.socialNetworks

                    self.usersRepository.saveUser(userRecord: userRecord, userInfoRecord: userInfosRecord) { _, error in
                        
                        guard error == nil else {
                            completionHandler(.fail, error)
                            return
                        }
                        completionHandler(.success, nil)
                    }
                case .Failed:
                    completionHandler(.fail, nil)
                }
            }
        }
    }
}
