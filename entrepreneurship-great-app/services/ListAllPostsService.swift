//
//  ListAllPostsService.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 08/10/20.
//

import Foundation
import CloudKit

class ListAllPostsService {
    let postsRepository: PostsRepository
    
    init() {
        self.postsRepository = PostsRepository()
    }
    
    public func execute(completionHandler: @escaping ([Post], Error?)->()){
        ListUserInformationService().execute(){
            userInfo, error in
                        
            guard let user = userInfo, error == nil else {
                print("Error finding user")
                completionHandler([], error)
                return
            }
            
            self.postsRepository.listAll{
                foundPosts, error in
                                
                guard let allPosts = foundPosts, error == nil else {
                    completionHandler([], error)
                    return
                }
                                
                guard let usersFollowing = user.following else {
                    completionHandler([], nil)
                    return
                }
                
                let allPostsByUsersFollowing = allPosts.filter {
                    usersFollowing.contains($0.author_id)
                }
                
                completionHandler(allPostsByUsersFollowing, nil)
            }
        }
    }
}
