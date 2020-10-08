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
