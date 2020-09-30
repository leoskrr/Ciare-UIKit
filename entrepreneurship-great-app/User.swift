//
//  User.swift
//  entrepreneurship-great-app
//
//  Created by Gustavo Anjos on 22/09/20.
//

import Foundation
import UIKit
import CloudKit
class User {
    var id: String
    var name: String
    var email: String
    var location: CLLocation?
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
         location: CLLocation? = nil,
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
        User(id: UUID().uuidString, name: "Misericórdia Store", email: "misericordiastore@apple.com", typeBusiness: .digital, areasExpertise: ["Design"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img1"),  availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),

        User(id: UUID().uuidString, name: "Os Barés", email: "bares@apple.com", typeBusiness: .fisico, areasExpertise: ["Artesanato"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img2"), availablePartnerships: false, partners: [], conversations: [], blocked: [], followers: [], following: []),

        User(id: UUID().uuidString, name: "Manaos", email: "manaos@apple.com", typeBusiness: .ambos, areasExpertise: ["Gráfica"], socialNetworks: [.facebook(account: "aaaaa"), .twitter(account: "aaaa")], picture: UIImage(named: "img3"), availablePartnerships: true, partners: [], conversations: [], blocked: [], followers: [], following: []),
    ]

    static let loggedUser = all[0]
}
