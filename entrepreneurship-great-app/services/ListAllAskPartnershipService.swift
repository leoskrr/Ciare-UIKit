//
//  ListAllAskPartnershipService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 13/10/20.
//

import Foundation
import CloudKit.CKRecord

class ListAllAskPartnershipService{
    var askedPartnershipsRepository: AskedPartnershipsRepository
    
    init() {
        self.askedPartnershipsRepository = AskedPartnershipsRepository()
    }
    
    public func execute(to toUser: CKRecord.ID, completionHandler: @escaping ([AskedPartnership]?, Error?)->() ){
        
        let toUserIdRef = CKRecord.Reference(recordID: toUser, action: .none)

        askedPartnershipsRepository.findAll(to: toUserIdRef){
            askedPartnership, error in
            
            guard let foundAskedPartnership = askedPartnership, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(foundAskedPartnership, nil)
        }
    }
}
