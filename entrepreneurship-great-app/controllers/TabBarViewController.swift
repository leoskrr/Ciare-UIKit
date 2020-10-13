//
//  TabBarViewController.swift
//  entrepreneurship-great-app
//
//  Created by Leonardo Viana on 08/10/20.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.items?[0].title = Translation.TabBar.home
        self.tabBar.items?[1].title = Translation.TabBar.post
        self.tabBar.items?[2].title = Translation.TabBar.notifications
        self.tabBar.items?[3].title = Translation.TabBar.profile

        AskedPartnershipsRepository().fetchSubscriptions()
    }
}
