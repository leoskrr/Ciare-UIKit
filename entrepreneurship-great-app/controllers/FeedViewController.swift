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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var authors: [UserInfo] = []
    var refresh: UIRefreshControl!
    
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
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1

        
        cell.fillCellData(post)
        
        cell.companyNameLabel.addGestureRecognizer(gestureRecognizer)
        cell.companyNameLabel.isUserInteractionEnabled = true
        

        if let author = authors.first(where: { $0.recordID == post.author_id.recordID }) {
            cell.fillCellData(post, author)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userCell = tableView.cellForRow(at: indexPath) as! MyPostTableViewCell
    }
    
    @objc func gestureTap (_ gesture: UITapGestureRecognizer){
        
        print("\n\ntapped\n\n")
        
        
        
        if let userId = userInfoId {
            print("\nAté aqui n deu bom\n")
            let selectedUser = usersFromCK.first { $0.recordID == userId }
            
            let personVC = self.storyboard?.instantiateViewController(withIdentifier: "personVC") as! PersonViewController
            
            self.definesPresentationContext = true
            
            personVC.modalPresentationStyle = .overCurrentContext
            personVC.person = selectedUser
            
            searchBar.resignFirstResponder()
            self.present(personVC, animated: false, completion: nil)
        }
        
    }
    
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
        }
        loadPostsFromDB()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: false, completion: nil)
    }
}

extension FeedViewController: UIScrollViewDelegate{
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
