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
    var typeBusiness: typesBusiness
    var areasExpertise: [String]?
    var socialNetworks: [socialNetworks]?
    var picture: UIImage?
    var availablePartnerships: Bool
    var partners: [User]?
    var conversations: [User]?
    var blocked: [User]?
    var followers: [User]?
    var following: [User]?

    init(id: String,
         name: String,
         email: String,
         password: String,
         location: String? = nil,
         typeBusiness: typesBusiness,
         areasExpertise: [String] = [],
         socialNetworks: [socialNetworks] = [],
         picture: UIImage?,
         availablePartnerships: Bool,
         partners: [User]?,
         conversations: [User]?,
         blocked: [User]?,
         followers: [User]?,
         following: [User]?)
    
    {
        
        self.id = id
        self.name = name
        self.email = name
        self.password = password
        self.location = location
        self.typeBusiness = typeBusiness
        self.areasExpertise = areasExpertise
        self.socialNetworks = socialNetworks
        self.picture = picture
        self.availablePartnerships = availablePartnerships
        self.partners = partners
        self.conversations = conversations
        self.blocked = blocked
        self.followers = followers
        self.following = following
    }
    
}
 
extension User{
    static var all = [
        User(id: UUID().uuidString, name: "Misericórdia Store", email: "misericordiastore@apple.com", password: "aaaa", typeBusiness: .digital, areasExpertise: ["Design"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img1"),  availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Os Barés", email: "bares@apple.com", password: "bbbb", typeBusiness: .fisico, areasExpertise: ["Artesanato"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img2"), availablePartnerships: false, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Manaos", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img3"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Grace Store", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Artesanato"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img2"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Gabriel Couto", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Tecnologia"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img1"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Gaúcho", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Influencer"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img2"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Los Barés", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Lanche"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img3"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Xibata Gráfica", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img1"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Joseph Paz", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img1"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Gusta Manaós", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Lanche"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img2"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Girl Power", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Lutas"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img2"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Telezé", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Humor"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img1"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
        
        User(id: UUID().uuidString, name: "Lia Cruz", email: "manaos@apple.com", password: "cccc", location: "Brasil", typeBusiness: .ambos, areasExpertise: ["Estúdio Tatoo"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img2"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: [])
    ]
    
    static let loggedUser = all[0]
}
