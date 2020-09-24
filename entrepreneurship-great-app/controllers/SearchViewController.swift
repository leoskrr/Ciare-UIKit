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
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.performSegue(withIdentifier: "backToFeedVC", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        filterUser = []
        
        if searchText == "" {
            filterUser = User.all
        }else{
            for nameUser in User.all{
                if nameUser.name.lowercased().contains(searchText.lowercased()){
                    filterUser.append(nameUser)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let personVC = self.storyboard?.instantiateViewController(withIdentifier: "personVC")
        self.definesPresentationContext = true
        personVC?.modalPresentationStyle = .overCurrentContext
        self.present(personVC!, animated: false, completion: nil)
        
        
    }
    

    

}
