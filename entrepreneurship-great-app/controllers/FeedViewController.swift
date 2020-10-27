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
    
    var posts: [Post] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadPostsFromDB(){
        showLoadingOnViewController(self)

        ListAllPostsService().execute{
            allPosts, error in

            DispatchQueue.main.async {
                removeLoadingOnViewController(self)
            }
            
            guard error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }

            self.posts = allPosts
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if posts.count == 0 {
            self.tableView.setEmptyMessage(Translation.Placeholder.emptyTableViewFeed)
        } else {
            tableView.restore()
        }
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyPostTableViewCell
        
        cell.fillCellData(post)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = Translation.Placeholder.searchBar
    }
        
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        loadPostsFromDB()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: false, completion: nil)
    }
}
