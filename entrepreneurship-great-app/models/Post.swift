//
//  Post.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 24/09/20.
//

import Foundation
import CloudKit

class Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.author_id
    }
    
    var id: CKRecord.ID?
    var author_id: CKRecord.Reference
    var description: String
    var image: CKAsset
        
    init(id: CKRecord.ID? = nil, author_id: CKRecord.Reference, description: String, image: CKAsset) {
        self.id = id
        self.author_id = author_id
        self.description = description
        self.image = image
    }
}
