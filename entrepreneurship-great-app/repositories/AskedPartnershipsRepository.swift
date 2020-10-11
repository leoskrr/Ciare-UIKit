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
                print("error")
                return
            }
            
            let askedPartnership = AskedPartnership(id: savedRecord.recordID,
                                                    byUser: byUser,
                                                    toUser: toUser)
        
            completionHandler(askedPartnership, nil)
        }
    }
    
    public func findOne(by byUser: CKRecord.Reference, to toUser: CKRecord.Reference, completionHandler: @escaping (AskedPartnership?, Error?)->()){
        let predicate = NSPredicate(format: "byUser == %@ AND toUser == %@", byUser, toUser)
        let query = CKQuery(recordType: "AskedPartnerships", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        executeQueryOperation(operation: operation){
            askeds, error in
            
            guard let array = askeds, error == nil else {
                return
            }
            
            if array.count > 0 {
                completionHandler(array.first!, nil)
            }
        }
    }
    
    private func executeQueryOperation(operation: CKQueryOperation, completionHandler: @escaping ([AskedPartnership]?, Error? ) -> ()){
        
        var askedPartnerships: [AskedPartnership] = []
        
        operation.recordFetchedBlock = {
            record in
            
            let askedPartnership = AskedPartnership(id: record.recordID,
                                                    byUser: record["byUser"] as! CKRecord.Reference,
                                                    toUser: record["toUser"] as! CKRecord.Reference)
            
            askedPartnerships.append(askedPartnership)
        }
        
        operation.queryCompletionBlock = {
            cursor, error in
            
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(askedPartnerships, nil)
        }
        
        self.publicDatabase.add(operation)
    }
}
