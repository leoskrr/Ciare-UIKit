//
//  AskedPartnershipsRepository.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 11/10/20.
//

import Foundation
import CloudKit

class AskedPartnershipsRepository{
    let publicDatabase: CKDatabase
    
    init() {
        self.publicDatabase = CKContainer(identifier: "iCloud.com.vianaleonardo.entrepreneurship").publicCloudDatabase
    }
    
    public func create(by byUser: CKRecord.Reference, to toUser: CKRecord.Reference, completionHandler: @escaping (AskedPartnership?, Error?)->()){
        
        let record = CKRecord(recordType: "AskedPartnerships")
        
        record["byUser"] = byUser
        record["toUser"] = toUser
        
        self.publicDatabase.save(record){
            record, error in
            
            guard let savedRecord = record, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let askedPartnership = AskedPartnership(id: savedRecord.recordID,
                                                    byUser: byUser,
                                                    toUser: toUser)
        
            completionHandler(askedPartnership, nil)
        }
    }
}
