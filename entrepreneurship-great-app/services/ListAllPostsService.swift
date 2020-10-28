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
    
    public func execute(excludePosts: [Post], completionHandler: @escaping ([Post], Error?)->()){
        
        var recordsIdsToExclude: [CKRecord.ID] = []
        
        for post in excludePosts {
            recordsIdsToExclude.append(post.id!)
        }
        
        ListUserInformationService().execute(){
            userInfo, error in
                        
            guard let user = userInfo, error == nil else {
                print("Error finding user")
                completionHandler([], error)
                return
            }
            
            guard let usersFollowing = user.following else {
                    completionHandler([], nil)
                    return
            }
            
            self.postsRepository.listsPostsByUsers(withIds: usersFollowing, excludePostsWithIds: recordsIdsToExclude){
                foundPosts, error in
                
                guard let posts = foundPosts, error == nil else {
                    completionHandler([], error)
                    return
                }
                
                completionHandler(posts, nil);
            }
        }
    }
}
