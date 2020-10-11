//
//  AskedPartnership.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 11/10/20.
//

import Foundation
import CloudKit.CKRecord

class AskedPartnership {
    var id: CKRecord.ID
    var byUser: CKRecord.Reference
    var toUser: CKRecord.Reference
    
    init(id: CKRecord.ID, byUser: CKRecord.Reference, toUser: CKRecord.Reference) {
        self.id = id
        self.byUser = byUser
        self.toUser = toUser
    }
}
