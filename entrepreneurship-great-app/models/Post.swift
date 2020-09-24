//
//  Post.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 24/09/20.
//

import Foundation
import UIKit

let users = User.all

class Post {
    var id: String
    var author_id: String
    var description: String?
    var picture: UIImage?
    var likes: Int
    var comments: Int
        
    init(id: String, author_id: String, description: String? = nil, picture: UIImage?, likes: Int, comments: Int) {
        self.id = id
        self.author_id = author_id
        self.description = description
        self.picture = picture
        self.likes = likes
        self.comments = comments
    }
}

extension Post {
    static let all = [
        Post(id:  UUID().uuidString, author_id: users[0].id, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis varius placerat elit ut viverra.", picture: UIImage(named: "img1"), likes: 100, comments: 50),
        Post(id:  UUID().uuidString, author_id: users[0].id, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis varius placerat elit ut viverra. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis varius placerat elit ut viverra. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis varius placerat elit ut viverra.", picture: UIImage(named: "img2"), likes: 10, comments: 2),
        Post(id:  UUID().uuidString, author_id: users[0].id, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", picture: UIImage(named: "img3"), likes: 1000, comments: 500),
    ]
}
