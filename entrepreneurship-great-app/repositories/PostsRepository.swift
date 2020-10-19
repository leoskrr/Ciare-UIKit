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
    
    public func listAll(completionHandler: @escaping ([Post]?, Error?) -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Post", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let operation = CKQueryOperation(query: query)
        
        executeQueryOperation(operation: operation) {
            posts, error in
            
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(posts, nil)
        }
    }
    
    public func listsPostsByUser(withId author_id: CKRecord.ID, completionHandler: @escaping ([Post]?, Error?) -> ()) {
        let predicate = NSPredicate(format: "author_id == %@", CKRecord.Reference(recordID: author_id, action: .none))
        let query = CKQuery(recordType: "Post", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let operation = CKQueryOperation(query: query)
        
        executeQueryOperation(operation: operation) {
            posts, error in
            
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(posts, nil)
        }
    }
    
    private func executeQueryOperation(operation: CKQueryOperation, completionHandler: @escaping ([Post]?, Error? ) -> ()){
        
        var posts: [Post] = []
        
        operation.recordFetchedBlock = {
            record in
            
            let post = Post(id: record.recordID,
                            author_id: record["author_id"] as! CKRecord.Reference,
                            description: record["description"] as! String,
                            image: record["image"] as! CKAsset)
            
            posts.append(post)
        }
        
        operation.queryCompletionBlock = {
            cursor, error in
            
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(posts, nil)
        }
        
        self.publicDatabase.add(operation)
    }
}
