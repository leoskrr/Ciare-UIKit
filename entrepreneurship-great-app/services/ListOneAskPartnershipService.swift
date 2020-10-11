//
//  ListOneAskPartnershipService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 11/10/20.
//

import Foundation
import CloudKit.CKRecord

class ListOneAskPartnershipService{
    var askedPartnershipsRepository: AskedPartnershipsRepository
    
    init() {
        self.askedPartnershipsRepository = AskedPartnershipsRepository()
    }
    
    public func execute(by byUser: CKRecord.ID, to toUser: CKRecord.ID, completionHandler: @escaping (AskedPartnership?, Error?)->() ){
        
        let byUserIdRef = CKRecord.Reference(recordID: byUser, action: .none)
        let toUserIdRef = CKRecord.Reference(recordID: toUser, action: .none)

        askedPartnershipsRepository.findOne(by: byUserIdRef, to: toUserIdRef){
            askedPartnership, error in
            
            guard let foundAskedPartnership = askedPartnership, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(foundAskedPartnership, nil)
        }
    }
}
