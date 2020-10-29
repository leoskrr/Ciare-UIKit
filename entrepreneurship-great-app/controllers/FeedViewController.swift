//
//  FeedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 23/09/20.
//

import UIKit
import CloudKit.CKRecord

class FeedViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var feedIsLoading = true
    var shouldLoadData: Bool = true
    
    var userInfoId: CKRecord.ID!
    
    var posts: [Post] = [] {
        didSet{
            posts = posts.filterDuplicates {
                $0.id == $1.id
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var authors: [UserInfo] = []
    var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = Translation.Placeholder.searchBar
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: Translation.Feed.reload)
        refresh.addTarget(self, action: #selector(loadPostsFromDB), for: .valueChanged)
        self.tableView.addSubview(refresh)
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if feedIsLoading {
            showLoadingOnViewController(self)
            loadPostsFromDB()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: false, completion: nil)
    }
    
    @objc func loadPostsFromDB(){
        ListAllPostsService().execute(excludePosts: posts){
            allPosts, allAuthors, error  in
            
            if self.feedIsLoading {
                DispatchQueue.main.async {
                    removeLoadingOnViewController(self)
                }
                self.feedIsLoading = false
            }
            
            guard error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            
            self.authors = allAuthors
            self.posts.append(contentsOf: allPosts)
            
            DispatchQueue.main.async {
                self.refresh.endRefreshing()
            }
        }
    }
}

extension FeedViewController: UIScrollViewDelegate{
    
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

        cell.feedView = self

        if let author = authors.first(where: { $0.recordID == post.author_id.recordID }) {
            cell.fillCellData(post, author)
        }

        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        shouldLoadData = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height){
            if !shouldLoadData {
                loadPostsFromDB()
            }
        }
    }
}
