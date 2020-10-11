//
//  CreateAskPartnershipService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 11/10/20.
//

import Foundation
import CloudKit.CKRecord

enum CreateAskPartnershipServiceResult {
    case success, failed
}

class CreateAskPartnershipService{
    
    var askedPartnershipsRepository: AskedPartnershipsRepository
    
    init() {
        self.askedPartnershipsRepository = AskedPartnershipsRepository()
    }
    
    public func execute(by byUser: CKRecord.ID, to toUser: CKRecord.ID, completionHandler: @escaping (CreateAskPartnershipServiceResult, AskedPartnership?, Error?)->() ){
        
        let byUserIdRef = CKRecord.Reference(recordID: byUser, action: .none)
        let toUserIdRef = CKRecord.Reference(recordID: toUser, action: .none)

        askedPartnershipsRepository.create(by: byUserIdRef, to: toUserIdRef){
            askedPartnership, error in
            
            guard let createdAskedPartnership = askedPartnership, error == nil else {
                completionHandler(.failed, nil, error)
                return
            }
            
            completionHandler(.success, createdAskedPartnership, nil)
        }
    }
}
