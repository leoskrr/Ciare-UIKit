//
//  SearchViewController.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 23/09/20.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filterUser: [User]!
    let usersRepository: UsersRepository
    
    required init?(coder: NSCoder) {
        self.usersRepository = UsersRepository()
        super.init(coder: coder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = filterUser[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchUserTableViewCell
        
        cell.fillCellData(user)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.becomeFirstResponder()
        filterUser = User.all
        
        // Do any additional setup after loading the view.
        
        searchBar.placeholder = Translation.Placeholder.searchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.performSegue(withIdentifier: "backToFeedVC", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        filterUser = []
        
        if searchText == "" {
            filterUser = User.all
        }else{
            for user in User.all{
                if user.name.lowercased().contains(searchText.lowercased()){
                    filterUser.append(user)
                }
                
                else if !(user.areasExpertise!.isEmpty){
                    if user.areasExpertise![0].lowercased().contains(searchText.lowercased()){
                        filterUser.append(user)
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let userCell = tableView.cellForRow(at: indexPath) as! SearchUserTableViewCell
        
        if let userId = userCell.userId {
            let selectedUser = usersRepository.findUserById(userId)
            
            let personVC = self.storyboard?.instantiateViewController(withIdentifier: "personVC") as! PersonViewController
            
            self.definesPresentationContext = true
            
            personVC.modalPresentationStyle = .overCurrentContext
            personVC.person = selectedUser
            
            searchBar.resignFirstResponder()
            self.present(personVC, animated: false, completion: nil)
        }
    }
}
