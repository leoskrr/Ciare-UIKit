//
//  User.swift
//  entrepreneurship-great-app
//
//  Created by Gustavo Anjos on 22/09/20.
//

import Foundation
import UIKit

class User {
    var name: String
    var email: String
    var password: String
    var location: String?
    var typeBuniness: typesBusiness
    var areasExpertise: [String]?
    var socialNetworks: [socialNetworks]?
    var picture: UIImage?
    
    init(name: String, email: String, password: String, location: String? = nil, typeBunisses: typesBusiness, areasExpertise: [String] = [], socialNetworks: [socialNetworks] = []) {
        self.name = name
        self.email = name
        self.password = password
        self.location = location
        self.typeBuniness = typeBunisses
        self.areasExpertise = areasExpertise
        self.socialNetworks = socialNetworks
        self.picture = UIImage(named: self.name)
    }
    
}
 

extension User{
    static let all = [
        User(name: "Misericordia Store", email: "misericordiastore@apple.com", password: "aaaa", typeBunisses: .digital, areasExpertise: ["Design"], socialNetworks: [.whatsapp, .facebook, .twitter]),
        User(name: "Os Barés", email: "bares@apple.com", password: "bbbb", typeBunisses: .fisico, areasExpertise: ["Artesanato"], socialNetworks: [.whatsapp, .instagram]),
        User(name: "Manaos", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.linkedin])
    ]
}



