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
        User(id: UUID().uuidString, name: "Manaos", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.linkedin], picture: UIImage(named: "img3"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Grace Store", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Artesanato"], socialNetworks: [.linkedin], picture: UIImage(named: "img2"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Gabriel Couto", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Tecnologia"], socialNetworks: [.linkedin], picture: UIImage(named: "img1"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Gaúcho", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Influencer"], socialNetworks: [.linkedin], picture: UIImage(named: "img2"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Los Barés", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Lanche"], socialNetworks: [.linkedin], picture: UIImage(named: "img3"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Xibata Gráfica", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.linkedin], picture: UIImage(named: "img1"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Joseph Paz", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.linkedin], picture: UIImage(named: "img1"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Gusta Manaós", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Lanche"], socialNetworks: [.linkedin], picture: UIImage(named: "img2"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Girl Power", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Lutas"], socialNetworks: [.linkedin], picture: UIImage(named: "img2"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Telezé", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Humor"], socialNetworks: [.linkedin], picture: UIImage(named: "img1"), availablePartnerships: true),
        User(id: UUID().uuidString, name: "Lia Cruz", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBunisses: .ambos, areasExpertise: ["Estúdio Tatoo"], socialNetworks: [.linkedin], picture: UIImage(named: "img2"), availablePartnerships: true)
    ]
}



