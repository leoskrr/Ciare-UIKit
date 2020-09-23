//
//  User.swift
//  entrepreneurship-great-app
//
//  Created by Gustavo Anjos on 22/09/20.
//

import Foundation
import UIKit

class User {
    var id: String
    var name: String
    var email: String
    var password: String
    var location: String?
    var typeBuniness: typesBusiness
    var areasExpertise: [String]?
    var socialNetworks: [socialNetworks]?
    var picture: UIImage?
    var availablePartnerships: Bool

    
    init(id: String, name: String, email: String, password: String, location: String? = nil, typeBunisses: typesBusiness, areasExpertise: [String] = [], socialNetworks: [socialNetworks] = [], picture: UIImage?, availablePartnerships: Bool) {
        
        self.id = id
        self.name = name
        self.email = name
        self.password = password
        self.location = location
        self.typeBuniness = typeBunisses
        self.areasExpertise = areasExpertise
        self.socialNetworks = socialNetworks
        self.picture = picture
        self.availablePartnerships = availablePartnerships
    }
    
}
 

extension User{
    static let all = [
        User(id: UUID().uuidString, name: "Misericórdia Store", email: "misericordiastore@apple.com", password: "aaaa", typeBunisses: .digital, areasExpertise: ["Design"], socialNetworks: [.whatsapp, .facebook, .twitter], picture: UIImage(named: "img1"),  availablePartnerships: true),
        User(id: UUID().uuidString, name: "Os Barés", email: "bares@apple.com", password: "bbbb", typeBunisses: .fisico, areasExpertise: ["Artesanato"], socialNetworks: [.whatsapp, .instagram], picture: UIImage(named: "img2"), availablePartnerships: false),
        User(id: UUID().uuidString, name: "Manaos", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.linkedin], picture: UIImage(named: "img3"), availablePartnerships: true)
    ]
}



