//
//  NotificationsViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 13/10/20.
//

import UIKit
import CloudKit.CKRecord

class NotificationsViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var notificationsLabel: UILabel!
    
    
    
   
    @IBOutlet weak var tableView: UITableView!
    var partnership: [AskedPartnership]? = []{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        if let count = partnership?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellNotifications1 = tableView.dequeueReusableCell(withIdentifier: "cellNotifications1", for: indexPath) as! Notifications1TableViewCell

        
        if let notifications = partnership {
            let notification = notifications[indexPath.row]
            
            cellNotifications1.fillCellWith(userInfoId: notification.byUser.recordID, notificationId: notification.id)
        }
        
        return cellNotifications1
    }
    
    func loadNotifications(){
        
        let recordId = CKRecord.ID(recordName: getUserInfoRecordNameFromUserDefaults()!)
                
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
        tableView.allowsSelection = false
        
        
        notificationsLabel.text = Translation.Notification.notificationsLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotifications()
    }
}
