//
//  SignUpUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 30/09/20.
//

import Foundation
import CloudKit
import CoreLocation

enum SignUpUserServiceError: Error {
    case unespecifiedName
}

class SignUpUserService {
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(name: String, location: CLLocation?){
        CKContainer.default().fetchUserRecordID {
            recordID, error in
            
            guard let recordID = recordID, error == nil else {
                return
            }
            
            self.usersRepository.fetchOneUser(withRecordID: recordID) {
                operationResult, record, error in
                
                switch operationResult {
                case .Successed:
                    record!["name"] = name
                    if let userLocation = location {
                        record!["location"] = userLocation
                    } 
                    self.usersRepository.saveUser(record: record!)
                case .Failed:
                    print("Erro ao salvar registro")
                }
                
            }
            
        }
    }
}
