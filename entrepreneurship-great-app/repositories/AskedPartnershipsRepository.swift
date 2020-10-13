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
    
    public func findAll(to toUser: CKRecord.Reference, completionHandler: @escaping ([AskedPartnership]?, Error?)->()){
        let predicate = NSPredicate(format: "toUser == %@", toUser)
        let query = CKQuery(recordType: "AskedPartnerships", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        executeQueryOperation(operation: operation){
            askeds, error in
            
            guard let array = askeds, error == nil else {
                return
            }
            completionHandler(array, nil)
        }
    }
    
    public func fetchSubscriptions(){
        publicDatabase.fetchAllSubscriptions(){
            subscriptions, error in
            
            guard let subscriptions = subscriptions, error == nil else {
                print(error!)
                return
            }
            
            for subscription in subscriptions {
                self.publicDatabase.delete(withSubscriptionID: subscription.subscriptionID){
                    str, error in
                    
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    
                }
            }
            
            let userRecordId = CKRecord.ID(recordName: getUserInfoRecordNameFromUserDefaults()!)
            let userRef = CKRecord.Reference(recordID: userRecordId, action: .none)
            
            let predicate = NSPredicate(format:"toUser == %@", userRef)
            let subscription = CKQuerySubscription(recordType: "AskedPartnerships", predicate: predicate, options: .firesOnRecordCreation)
            
            let notification = CKSubscription.NotificationInfo()
            notification.alertBody = Translation.Notification.newPartnershipRequest
            
            subscription.notificationInfo = notification
            
            self.publicDatabase.save(subscription){
                result, error in
                
                guard error == nil else {
                    print(error!)
                    return
                }
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
