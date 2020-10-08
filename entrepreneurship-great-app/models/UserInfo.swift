//
//  UserInfo.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 07/10/20.
//

import Foundation
import CloudKit

class UserInfo: NSObject {
    var name: String
    var recordID: CKRecord.ID?
    var location: CLLocation?
    var picture: CKAsset?
    var availablePartnerships: Int64?
    var typeBusiness: String?
    var expertiseAreas: [String]?
    var socialNetworks: [String]?
    
    init(name: String,
         recordID: CKRecord.ID? = nil,
         location: CLLocation? = nil,
         picture: CKAsset? = nil,
         availablePartnerships: Int64? = nil,
         expertiseAreas: [String]? = nil,
         socialNetworks: [String]? = nil,
         typeBusiness: String? = nil) {
        
        self.recordID = recordID
        self.name = name
        self.location = location
        self.picture = picture
        self.availablePartnerships = availablePartnerships
        self.expertiseAreas = expertiseAreas
        self.socialNetworks = socialNetworks
        self.typeBusiness = typeBusiness
    }
}
