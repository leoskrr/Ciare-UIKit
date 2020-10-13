//
//  DeleteRequestPartnershipService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 13/10/20.
//

import Foundation
import CloudKit.CKRecord

class DeleteRequestPartnershipService{
    var askedPartnershipsRepository: AskedPartnershipsRepository
    
    init() {
        self.askedPartnershipsRepository = AskedPartnershipsRepository()
    }
    
    public func execute(id: CKRecord.ID){
        askedPartnershipsRepository.delete(withId: id)
    }
}
