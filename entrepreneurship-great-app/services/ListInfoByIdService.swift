//
//  ListInfoById.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 09/10/20.
//

import Foundation

import Foundation
import CloudKit

class ListInfoByIdService {
    var usersRepository: UsersRepository
    
    init(){
        self.usersRepository = UsersRepository()
    }
    
    public func execute(recordId: CKRecord.ID, completionHandler: @escaping (UserInfo?, Error?)->()){
        
        self.usersRepository.fetchOneUser(withRecordID: recordId){
            _, record, error in
            
            guard let userInfoRecord = record, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let userInfo = UserInfo(name: userInfoRecord["name"] as! String)
            
            userInfo.recordID = userInfoRecord.recordID
            userInfo.availablePartnerships = userInfoRecord["availablePartnerships"] as? Int64
            userInfo.location = userInfoRecord["locale"] as? String
            userInfo.picture = userInfoRecord["picture"] as? CKAsset
            userInfo.expertiseAreas = userInfoRecord["expertiseAreas"] as? [String]
            userInfo.socialNetworks = userInfoRecord["socialNetworks"] as? [String]
            userInfo.typeBusiness = userInfoRecord["typeBusiness"] as? String
            
            if let followers = userInfoRecord["followers"] as? [CKRecord.Reference]{
                userInfo.followers = Array(Set(followers))
            }
            
            if let following = userInfoRecord["following"] as? [CKRecord.Reference]{
                userInfo.following = Array(Set(following))
            }
            
            if let partners = userInfoRecord["partners"] as? [CKRecord.Reference]{
                userInfo.partners = Array(Set(partners))
            }
            
            completionHandler(userInfo, nil)
        }
    }
}
