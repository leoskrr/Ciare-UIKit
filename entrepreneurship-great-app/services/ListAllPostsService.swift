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
    let usersRepository: UsersRepository
    
    init() {
        self.postsRepository = PostsRepository()
        self.usersRepository = UsersRepository()
    }
    
    public func execute(excludePosts: [Post], completionHandler: @escaping ([Post], [UserInfo], Error?)->()){
        
        var recordsIdsToExclude: [CKRecord.ID] = []
        
        for post in excludePosts {
            recordsIdsToExclude.append(post.id!)
        }
        
        ListUserInformationService().execute(){
            userInfo, error in
                        
            guard let user = userInfo, error == nil else {
                print("Error finding user")
                completionHandler([], [], error)
                return
            }
            
            guard let usersFollowing = user.following else {
                completionHandler([], [], nil)
                return
            }
            
            
            self.postsRepository.listsPostsByUsers(withIds: usersFollowing, excludePostsWithIds: recordsIdsToExclude){
                foundPosts, error in
                
                guard let posts = foundPosts, error == nil else {
                    completionHandler([], [], error)
                    return
                }
                
                var authors: [CKRecord.ID] = []
                
                for author in usersFollowing {
                    authors.append(author.recordID)
                }
                
                self.usersRepository.loadUsersWithIds(authors){
                    loadedUsers, error in
                    
                    guard let loadedAuthors = loadedUsers, error == nil else {
                        completionHandler([], [], error)
                        return
                    }
                    
                    completionHandler(posts, loadedAuthors, nil)
                }
            }
        }
    }
}
