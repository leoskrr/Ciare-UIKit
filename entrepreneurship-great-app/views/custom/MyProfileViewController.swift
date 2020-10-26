//
//  MyProfileViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 12/10/20.
//

import UIKit
import CloudKit.CKRecord

class MyProfileViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: UserInfo? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var posts: [Post] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if posts.count == 0 {
            self.tableView.setEmptyMessage(Translation.Placeholder.emptyTableViewPosts)
        } else {
            tableView.restore()
        }
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentPost = posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMy", for: indexPath) as! MyProfileTableViewCell
        
        if let userExist = user {
            cell.fillCellData(currentPost, userExist)
        } else {
            cell.fillWithLoadingData()
        }
        
        return cell
    }
    
    func loadUserAndPostData(){
        ListUserInformationService().execute(){
            user, error in
            
            guard let info = user, error == nil else {
                print("")
                return
            }
            
            self.user = info
        }
    }
    
    func loadPostsFromDB(){
        let userInfoId = CKRecord.ID(recordName: getUserInfoRecordNameFromUserDefaults()!)
        
        showLoadingOnViewController(self)
        
        ListPostsByUserService().execute(userInfoId: userInfoId){
            _, allPosts, error in
            
            DispatchQueue.main.async {
                removeLoadingOnViewController(self)
            }
            
            guard let userPosts = allPosts, error == nil else {
                print("Could not load posts")
                return
            }
            
            self.posts = userPosts
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPostsFromDB()
        loadUserAndPostData()
    }
}
