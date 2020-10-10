//
//  FeedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 23/09/20.
//

import UIKit

class FeedViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    var userInfos: UserInfo? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadPersonData(){
        ListUserInformationService().execute(){
            info, error in
            
            guard let user = info, error == nil else {
                return
            }
            self.userInfos = user
        }
    }
    
    func loadPostsFromDB(){
        ListAllPostsService().execute{
            allPosts, error in

            self.posts = allPosts
            self.loadPersonData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyPostTableViewCell
        
        if userInfos !== nil {
            cell.fillCellData(post, userInfos!)
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPostsFromDB()
        searchBar.placeholder = Translation.Placeholder.searchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: false, completion: nil)
    }
}
