//
//  ListPostsByUserService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 08/10/20.
//

import Foundation
import CloudKit

enum ListPostsByUserServiceResult {
    case success, failed
}

class ListPostsByUserService {
    let postsRepository: PostsRepository
    
    init() {
        self.postsRepository = PostsRepository()
    }
    
    public func execute(userInfoId: CKRecord.ID, completionHandler: @escaping (ListPostsByUserServiceResult, [Post]?, Error?)->()){
        
        postsRepository.listsPostsByUser(withId: userInfoId) {
            posts, error in
            
            guard error == nil else {
                completionHandler(.failed, nil, error)
                return
            }
            
            completionHandler(.success, posts, nil)
        }
    }
}
