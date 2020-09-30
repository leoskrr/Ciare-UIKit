//
//  Enums.swift
//  entrepreneurship-great-app
//
//  Created by Gustavo Anjos on 22/09/20.
//

import Foundation

enum typesBusiness: String {
    case digital
    case fisico
    case ambos
}

enum socialNetworks {
    case instagram(account: String)
    case facebook(account: String)
    case twitter(account: String)
    case linkedin(account: String)
    case tiktok(account: String)
    case whatsapp(number: String)
}
