//
//  SignInUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 01/10/20.
//

import Foundation
import CloudKit

class SignInUserService {
    var usersRepository: UsersRepository
    
    init() {
        self.usersRepository = UsersRepository()
    }
    
    public func execute(){
        CKContainer.default().fetchUserRecordID {
            recordID, error in
            
            guard let recordID = recordID, error == nil else {
                return
            }
            
            do{
                try self.usersRepository.fetchUser(recordID: recordID)
            } catch {
                print(error)
            }
        }
        print("SIGN IN SUCCESS!")
    }
}
