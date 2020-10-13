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
    
    var usersFromCK: [UserInfo]?
    
    var filterUser: [UserInfo]!
    let usersRepository: UsersRepository
    
    required init?(coder: NSCoder) {
        self.usersRepository = UsersRepository()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ListAllUsersService().execute() {
            allUsers, error in

            guard let users = allUsers, error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            
            self.usersFromCK = users
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
        searchBar.placeholder = Translation.Placeholder.searchBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let users = filterUser {
            return users.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = filterUser[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchUserTableViewCell
        
        cell.fillCellData(user)
        
        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.performSegue(withIdentifier: "backToFeedVC", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        filterUser = []
        
        guard let users = usersFromCK else {
            DispatchQueue.main.async {
                showAlertError(self, text: Translation.Error.server)
            }
            return
        }
        
        if searchText == "" {
            filterUser = []
        }else{
            for user in users{
                if user.name.lowercased().contains(searchText.lowercased()){
                    filterUser.append(user)
                }
                
                else if !(user.expertiseAreas!.isEmpty){
                    if user.expertiseAreas![0].lowercased().contains(searchText.lowercased()){
                        filterUser.append(user)
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let userCell = tableView.cellForRow(at: indexPath) as! SearchUserTableViewCell
        
        if let userId = userCell.userInfoId {
            let selectedUser = usersFromCK?.first { $0.recordID == userId }
            
            let personVC = self.storyboard?.instantiateViewController(withIdentifier: "personVC") as! PersonViewController
            
            self.definesPresentationContext = true
            
            personVC.modalPresentationStyle = .overCurrentContext
            personVC.person = selectedUser
            
            searchBar.resignFirstResponder()
            self.present(personVC, animated: false, completion: nil)
        }
    }
}
