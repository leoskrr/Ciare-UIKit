//
//  Translation.swift
//  entrepreneurship-great-app
//
//  Created by Gustavo Anjos on 30/09/20.
//

import Foundation

class Translation {
    
    class Placeholder {
        static let btnFollow = NSLocalizedString("PersonViewController.placeholder.btnFollow", comment: "")
        
        static let searchBar = NSLocalizedString("SearchViewController.placeholder.searchBar", comment: "")
        
        static let askPartnership = NSLocalizedString("PersonViewController.placeholder.askPartnership", comment: "")
        
        static let askedPartnership = NSLocalizedString("PersonViewController.placeholder.askedPartnership", comment: "")
        
        static let brandName = NSLocalizedString("RegisterViewController.info.labelNameCompany", comment: "")
    }
    
    class Info {
        static let partners = NSLocalizedString("PersonViewController.info.labelPartners", comment: "")
        
        static let followers = NSLocalizedString("PersonViewController.info.labelFollowers", comment: "")
        
        static let following = NSLocalizedString("PersonViewController.info.labelFollowing", comment: "")
        
        static let my = NSLocalizedString("PersonViewController.alert.labelMy", comment: "")
        
        static let register = NSLocalizedString("RegisterViewController.info.labelRegister", comment: "")
        
        static let company = NSLocalizedString("RegisterViewController.info.labelCompany", comment: "")
        
        static let businessType = NSLocalizedString("RegisterViewController.info.labelBusinessType", comment: "")
    }
    
    class Alert{
        static let cancel = NSLocalizedString("PersonViewController.alert.alertCancel", comment: "")
        
        static let message = NSLocalizedString("PersonViewController.alert.alertMessage", comment: "")
        
        static let unfollow = NSLocalizedString("PersonViewController.alert.alertUnfollow", comment: "")
        
        static let blockUser = NSLocalizedString("PersonViewController.alert.alertBlockUser", comment: "")
        
        static let title = NSLocalizedString("PersonViewController.alert.alertTitle", comment: "")
        
        static let subtitle = NSLocalizedString("PersonViewController.alert.alertSubTitle", comment: "")
    }
    
    class Assecibility {
        static let profile = NSLocalizedString("PersonViewController.assecibility.profile", comment: "")
    }
    
    class segmentedControl{
        static let physical = NSLocalizedString("RegisterViewController.segmentedControl.labelPhysical", comment: "")
        
        static let digital = NSLocalizedString("RegisterViewController.segmentedControl.labelDigital", comment: "")
        
        static let both = NSLocalizedString("RegisterViewController.segmentedControl.labelBoth", comment: "")
    }
    
}
