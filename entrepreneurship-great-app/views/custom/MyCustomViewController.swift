//
//  MyCustomViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 09/10/20.
//

import UIKit

class MyCustomViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var personViewController: PersonViewController?
    var person: UserInfo!

    var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    } 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyPostTableViewCell
        
        cell.fillCellData(post, person)
        
        return cell
    }
    
    func loadPostsFromDB(){
        let userInfoId = personViewController?.person?.recordID
        showLoadingOnViewController(self)

        ListPostsByUserService().execute(userInfoId: userInfoId!){
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
        self.person = personViewController!.person!
        
        loadPostsFromDB()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
