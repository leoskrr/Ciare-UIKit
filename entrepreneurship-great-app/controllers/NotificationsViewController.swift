//
//  NotificationsViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 13/10/20.
//

import UIKit
import CloudKit.CKRecord

class NotificationsViewController: UIViewController, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var partnership: [AskedPartnership]? = []{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("aa")
        
        if let count = partnership?.count {
            print(count)
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellNotifications1 = tableView.dequeueReusableCell(withIdentifier: "cellNotifications1", for: indexPath) as! Notifications1TableViewCell

        
        if let notifications = partnership {
            let notification = notifications[indexPath.row]
            
            cellNotifications1.fillCellWith(userInfoId: notification.toUser.recordID)
        }
        
        return cellNotifications1
    }
    
    func loadNotifications(){
        
        let recordId = CKRecord.ID(recordName: getUserRecordNameFromUserDefaults()!)
        
        ListAllAskPartnershipService().execute(to: recordId){
            partnerships, error in
            
            guard let array = partnerships, error == nil else {
                print(error!)
                return
            }
            
            self.partnership = array
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotifications()
    }
}
