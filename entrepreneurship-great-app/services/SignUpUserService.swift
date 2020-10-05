//
//  SignUpUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 30/09/20.
//

import Foundation
import CloudKit

enum SignUpUserServiceError: Error {
    case unespecifiedName
}

class SignUpUserService {
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(name: String){
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
                    self.usersRepository.saveUser(record: record!)
                case .Failed:
                    print("Erro ao salvar registro")
                }
                
            }
            
        }
    }
}
