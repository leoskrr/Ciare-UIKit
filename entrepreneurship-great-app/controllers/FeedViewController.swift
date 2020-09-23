//
//  FeedViewController.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 23/09/20.
//

import UIKit

class FeedViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.performSegue(withIdentifier: "goToSearchVC", sender: self)
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
