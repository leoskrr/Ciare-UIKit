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

public func storeUserInfoRecordNameInUserDefaults(_ id: CKRecord.Reference){
    let defaults = UserDefaults.standard
    
    defaults.setValue(id.recordID.recordName, forKey: "userInfoRecordName")
}

public func getUserInfoRecordNameFromUserDefaults() -> String?{
    let defaults = UserDefaults.standard
    
    let rn = defaults.string(forKey: "userInfoRecordName")
    
    guard let recordName = rn else {
        return nil
    }
    
    return recordName
}

public func setUserLoggedInApplicationStatus(_ status: Bool){
    let defaults = UserDefaults.standard
    
    defaults.setValue(status, forKey: "isUserLoggedInApp")
}

public func getUserLoggedInApplicationStatus() -> Bool{
    let defaults = UserDefaults.standard
    
    let status = defaults.bool(forKey: "isUserLoggedInApp")
    
    return status
}

public func setCurrentSegmentedIndexOnRegister(_ index: Int){
    let defaults = UserDefaults.standard
    
    defaults.setValue(index, forKey: "currentSegmentedIndexOnRegister")
}

public func getCurrentSegmentedIndexOnRegister() -> Int{
    let defaults = UserDefaults.standard
    
    let index = defaults.integer(forKey: "currentSegmentedIndexOnRegister")
    
    return index
}
