//
//  SignUpUser.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 30/09/20.
//

import Foundation
import CloudKit

class SignUpUser {
    
    public func execute(userId: String, name: String?, email: String){
        let publicDatabase = CKContainer(identifier: "iCloud.com.vianaleonardo.entrepreneurship").publicCloudDatabase
        let record = CKRecord(recordType: "User", recordID: CKRecord.ID(recordName: userId))
        
        record["name"] = name
        record["email"] = email
        
        publicDatabase.save(record) {_,_ in
            UserDefaults.standard.setValue(record.recordID.recordName, forKey: "userProfileId")
        }
        
    }
}
