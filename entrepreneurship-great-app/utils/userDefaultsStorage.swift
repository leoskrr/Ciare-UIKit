//
//  userDefaultsStorage.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 08/10/20.
//

import Foundation
import CloudKit

public func storeUserRecordNameInUserDefaults(_ id: CKRecord.ID){
    let defaults = UserDefaults.standard
    
    defaults.setValue(id.recordName, forKey: "userRecordName")
}

public func getUserRecordNameFromUserDefaults() -> String?{
    let defaults = UserDefaults.standard
    
    let rn = defaults.string(forKey: "userRecordName")
    
    guard let recordName = rn else {
        return nil
    }
    
    return recordName
}

//public func storeUserInformations(userInfo: UserInfo){
//    let defaults = UserDefaults.standard
//    
//    defaults.setValue(userInfo.name, forKey: "userName")
//    defaults.setValue(userInfo.availablePartnerships, forKey: "userName")
//    defaults.setValue(userInfo.expertiseAreas, forKey: "userName")
//    defaults.setValue(userInfo.followers?.count, forKey: "userName")
//    defaults.setValue(userInfo.following?.count, forKey: "userName")
//    defaults.setValue(userInfo.partners?.count, forKey: "userName")
//    defaults.setValue(userInfo., forKey: "userName")
//    defaults.setValue(userInfo.name, forKey: "userName")
//    defaults.setValue(userInfo.name, forKey: "userName")
//
//}
//
//public func getUserInformations() -> UserInfo? {
//    
//}
