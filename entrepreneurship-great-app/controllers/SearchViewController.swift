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
    
    let usersRepository: UsersRepository
    
    var usersFromCK: [UserInfo] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        self.usersRepository = UsersRepository()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadUsers(withText: String){
        
        if(withText.count == 1){
            showLoadingOnViewController(self)
        }
        
        ListAllUsersByCharactersService().execute(characters: withText){
            allUsers, error in
            
            DispatchQueue.main.async {
                removeLoadingOnViewController(self)
            }
            
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersFromCK.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = usersFromCK[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchUserTableViewCell
        
        cell.fillCellData(user)
        
        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.performSegue(withIdentifier: "backToFeedVC", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            usersFromCK = []
        }else{
            loadUsers(withText: searchText)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let userCell = tableView.cellForRow(at: indexPath) as! SearchUserTableViewCell
        
        if let userId = userCell.userInfoId {
            let selectedUser = usersFromCK.first { $0.recordID == userId }
            
            let personVC = self.storyboard?.instantiateViewController(withIdentifier: "personVC") as! PersonViewController
            
            self.definesPresentationContext = true
            
            personVC.modalPresentationStyle = .overCurrentContext
            personVC.person = selectedUser
            
            searchBar.resignFirstResponder()
            self.present(personVC, animated: false, completion: nil)
        }
    }
}
