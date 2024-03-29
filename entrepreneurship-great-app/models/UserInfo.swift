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
    var location: String?
    var picture: CKAsset?
    var availablePartnerships: Int64?
    var typeBusiness: String?
    var expertiseAreas: [String]?
    var socialNetworks: [String]?
    var followers: [CKRecord.Reference]?
    var following: [CKRecord.Reference]?
    var partners: [CKRecord.Reference]?

    init(name: String,
         recordID: CKRecord.ID? = nil,
         location: String? = nil,
         picture: CKAsset? = nil,
         availablePartnerships: Int64? = nil,
         expertiseAreas: [String]? = nil,
         socialNetworks: [String]? = nil,
         typeBusiness: String? = nil,
         followers: [CKRecord.Reference]? = [],
         following: [CKRecord.Reference]? = [],
         partners: [CKRecord.Reference]? = []) {
        
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
