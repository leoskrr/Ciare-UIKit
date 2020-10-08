//
//  PostsRepository.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 08/10/20.
//

import Foundation
import CloudKit

class PostsRepository {
    let publicDatabase: CKDatabase
    
    init() {
        self.publicDatabase = CKContainer(identifier: "iCloud.com.vianaleonardo.entrepreneurship").publicCloudDatabase
    }
    
    public func save(post: Post, completionHandler: @escaping (Post?, Error?) -> ()){
        var recordToSave = CKRecord(recordType: "Post")
        
        if let postId = post.id {
            recordToSave = CKRecord(recordType: "Post", recordID: postId)
        }
        
        recordToSave["author_id"] = post.author_id
        recordToSave["description"] = post.description
        recordToSave["image"] = post.image
        
        self.publicDatabase.save(recordToSave) {
            record, error in
            
            guard let savedRecord = record, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let savedPost = Post(id: savedRecord.recordID,
                                 author_id: CKRecord.Reference(recordID: savedRecord.recordID, action: .none),
                                 description: savedRecord["description"] as! String,
                                 image: savedRecord["image"] as! CKAsset)
            
            completionHandler(savedPost, nil)
        }
    }
}
