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
    
    public func saveUser(record: CKRecord){
        self.publicDatabase.save(record) {_,error in
            guard error == nil else {
                print("Error")
                return
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
