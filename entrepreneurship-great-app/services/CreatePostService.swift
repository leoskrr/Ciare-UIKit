//
//  CreatePostService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 08/10/20.
//

import Foundation

enum CreatePostServiceResult {
    case success, failed
}

class CreatePostService {
    let postsRepository: PostsRepository
    
    init() {
        self.postsRepository = PostsRepository()
    }
    
    public func execute(post: Post, completionHandler: @escaping (CreatePostServiceResult, Post?, Error?)->()){
        postsRepository.save(post: post) {
            savedPost, error in
            
            guard error == nil else {
                completionHandler(.failed, nil, error)
                return
            }
            
            completionHandler(.success, savedPost, nil)
        }
    }
}
