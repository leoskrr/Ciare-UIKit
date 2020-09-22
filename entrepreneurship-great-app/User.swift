//
//  User.swift
//  entrepreneurship-great-app
//
//  Created by Gustavo Anjos on 22/09/20.
//

import Foundation

class User {
    var name: String
    var email: String
    var password: String
    var location: String?
    
    init(name: String, email: String, password: String, location: String? = nil) {
        self.name = name
        self.email = name
        self.password = password
        self.location = location
    }
    
}

extension User{
    static let all = [
        User(name: "Misericordia Store", email: "misericordiastore@apple.com", password: "aaaa", location: "")
    ]
}
