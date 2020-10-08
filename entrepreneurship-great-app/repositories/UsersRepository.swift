//
//  UsersRepository.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 24/09/20.
//

import Foundation
import UIKit
import CloudKit

enum OperationResult {
    case Successed
    case Failed
}

class UsersRepository{
    
    let publicDatabase: CKDatabase
    
    init() {
        self.publicDatabase = CKContainer(identifier: "iCloud.com.vianaleonardo.entrepreneurship").publicCloudDatabase
    }
    
    public func saveUser(userRecord: CKRecord, userInfoRecord: CKRecord, completionHandler: @escaping (CKRecord?, Error?) -> ()){
                
        self.publicDatabase.save(userInfoRecord) { record, error in
            guard let savedRecord = record, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            userRecord["informations"] = CKRecord.Reference(recordID: savedRecord.recordID, action: .none)
            
            self.publicDatabase.save(userRecord) {
                record, error in
                
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(savedRecord, nil)
            }
        }
    }
    
    public func fetchOneUser(withRecordID recordID: CKRecord.ID, completionHandler: @escaping (OperationResult,CKRecord?, Error?) -> ()){
        self.publicDatabase.fetch(withRecordID: recordID) { record, error in
            guard let user = record, error == nil else {
                completionHandler(.Failed, nil, error)
                return
            }
            completionHandler(.Successed, user, nil)
        }
    }
    
    public func listAllUsers(completionHandler: @escaping ([UserInfo]?, Error?) -> ()){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UsersInfos", predicate: predicate)
        let operation = CKQueryOperation(query: query)
                
        self.executeQueryOperation(operation: operation) {
            usersInformations, error in
            
            guard let users = usersInformations, error == nil else {
                completionHandler(nil, error)
                return
            }
        
            completionHandler(users, nil)
        }
    }
    
    /**
    List all users informations that the name begins with a specific value.
     - Parameters:
        - value: Characters that are going to be used for querying users. All users containing this value will be returned.
        - completionHandler: The block to execute with the results.
        - userInfos: all the users informations founded. If no such usersInfos is founded this variable is nil.
        - error: an error object or nil if the operation is successfully executed.
    */
    public func listAllUsersByNameContaining(_ value: String, completionHandler: @escaping ([UserInfo]?, Error?) -> ()){
        
        let predicate = NSPredicate(format: "name BEGINSWITH %@", value)
        let query = CKQuery(recordType: "UsersInfos", predicate: predicate)
        let operation = CKQueryOperation(query: query)

        self.executeQueryOperation(operation: operation) {
            usersInformations, error in
            
            guard let users = usersInformations, error == nil else {
                completionHandler(nil, error)
                return
            }
        
            completionHandler(users, nil)
        }
    }
    
    public func findUserById(_ id: String) -> User? {
        if let user = User.all.first(where: { $0.id == id }) {
            return user
        }
        return nil
    }
    
    private func executeQueryOperation(operation: CKQueryOperation, completionHandler: @escaping ([UserInfo]?, Error? ) -> ()) {
        
        var usersInformations: [UserInfo] = []
                
        operation.recordFetchedBlock = {
            record in
                        
            let user = UserInfo(name: record["name"] as! String, recordID: record.recordID)

            user.availablePartnerships = record["availablePartnerships"] as? Int64
            user.location = record["location"] as? CLLocation
            user.picture = record["picture"] as? CKAsset
            user.typeBusiness = record["typeBusiness"] as? String
            user.expertiseAreas = record["expertiseAreas"] as? [String]
            user.socialNetworks = record["socialNetworks"] as? [String]
                        
            usersInformations.append(user)
        }
        
        operation.queryCompletionBlock = {
            cursor, error in
            
            if let error = error {
                completionHandler(nil, error)
            } else {
                completionHandler(usersInformations, nil)
            }
        }
        
        self.publicDatabase.add(operation)
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
