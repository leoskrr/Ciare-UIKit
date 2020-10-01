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
    }
    
    public func saveUser(userId: String, name: String, email: String){
        let record = CKRecord(recordType: "Users", recordID: CKRecord.ID(recordName: userId))
        
        record["name"] = name
        record["email"] = email
        
        publicDatabase.save(record) { record, err in
//            UserDefaults.standard.setValue(record.recordID.recordName, forKey: "userProfileId")
            if let user = record {
                print("\n\n User successfully saved \n\n")
                print(user)
            }
            if let error = err {
                print("\n\n Error saving user \n\n")
                print(error)
            }
            //criar retorno de objeto da classe User se der tudo certo
        }
        //retornar nil se der errado
    }
    
    public func fetchUser(userId: String){
        publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userId)) { (record, error) in
            if let fetchedInfo = record {
                print(fetchedInfo)
//                let name = fetchedInfo["name"] as? String
//                let email = fetchedInfo["email"] as? String
//                let expertiseAreas = fetchedInfo["expertiseAreas"] as? [String]
//                let location = fetchedInfo["location"] as? CLLocation?
//                let socialNetworks = fetchedInfo["socialNetworks"] as? [String]
//                let typeBusiness = fetchedInfo["typeBusiness"] as? String
//                let availablePartnerships = fetchedInfo["availablePartnerships"] as? Int

                //You can now use the user name and email address (like save it to local)
//                UserDefaults.standard.set(name, forKey: "userName")
//                UserDefaults.standard.set(userId, forKey: "userProfileID")
            }
            if let handleError = error {
                print(handleError)
            }
        }
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
    
}
