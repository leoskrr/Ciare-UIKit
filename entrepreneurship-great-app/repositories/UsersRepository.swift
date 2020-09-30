//
//  UsersRepository.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 24/09/20.
//

import Foundation
import UIKit
import CloudKit

class UsersRepository{
    
    let publicDatabase: CKDatabase
    
    init() {
        self.publicDatabase = CKContainer(identifier: "iCloud.com.vianaleonardo.entrepreneurship").publicCloudDatabase
//        self.record = CKRecord(recordType: "User", recordID: CKRecord.ID(recordName: userId))
    }
    
    public func findUserById(_ id: String) -> User? {
        if let user = User.all.first(where: { $0.id == id }) {
            return user
        }
        return nil
    }
    
    public func updateUser(_ user: User?) -> User? {
        
        if let userExists = user {
            if let userIndexInArray = User.all.firstIndex(where: { $0.id == userExists.id }) {
                User.all[userIndexInArray] = userExists
                
                return userExists
            }
            return nil
        }
        return nil
    }
    
    public func fetchUser(userId: String) -> User?{
        publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userId)) { (record, error) in
            if let fetchedInfo = record {
                
                let name = fetchedInfo["name"] as? String
//                let email = fetchedInfo["email"] as? String
//                let expertiseAreas = fetchedInfo["expertiseAreas"] as? [String]
//                let location = fetchedInfo["location"] as? CLLocation?
//                let socialNetworks = fetchedInfo["socialNetworks"] as? [String]
//                let typeBusiness = fetchedInfo["typeBusiness"] as? String
//                let availablePartnerships = fetchedInfo["availablePartnerships"] as? Int
                
//                let fetchedUser = User(id: userId, name: name, email: email, location: location, typeBusiness: typeBusiness, areasExpertise: expertiseAreas, socialNetworks: socialNetworks, picture: nil, availablePartnerships: Bool(availablePartnerships as NSNumber), partners: nil, conversations: nil, blocked: nil, followers: nil, following: nil)

                //You can now use the user name and email address (like save it to local)
                UserDefaults.standard.set(name, forKey: "userName")
                UserDefaults.standard.set(userId, forKey: "userProfileID")
            }
        }
        return nil
    }
}
