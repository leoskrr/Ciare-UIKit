//
//  PersonViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 24/09/20.
//

import UIKit

class PersonViewController: UIViewController, CustomSegmentedControlDelegate {
    
    var person: User?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var niche: UILabel!
    @IBOutlet weak var partnershipsQuantity: UILabel!
    @IBOutlet weak var followingQuantity: UILabel!
    @IBOutlet weak var followersQuantity: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var partnersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Meus","MidiaKit","MoodBoard"])
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
        }
    }
    
    func change(to index: Int) {
        print(index)
    }
    
    func loadPersonDataOnView(){
        if let person = self.person {
            profileImage.image = person.picture
            name.text = person.name
            niche.text = person.areasExpertise?[0] ?? ""
            partnershipsQuantity.text = "\(person.partners?.count ?? 0)"
            followingQuantity.text = "\(person.following?.count ?? 0)"
            followersQuantity.text = "\(person.partners?.count ?? 0)"
        }
    }
    
    @IBAction func onTouchUpButton(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assecibilityApple()
        
        loadPersonDataOnView()
        
        interfaceSegmented.delegate = self
        
        followButton.setTitle(Translation.Placeholder.btnFollow, for: .normal)
        partnersLabel.text = Translation.Info.partners
        followingLabel.text = Translation.Info.following
        followersLabel.text = Translation.Info.followers
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToSearchView(_ sender: Any) {
        
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
        
        self.definesPresentationContext = true
        
        searchVC.modalPresentationStyle = .overCurrentContext
        self.present(searchVC, animated: false, completion: nil)
    }
    
    @IBAction func actionViewButton(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Ações", message: "Selecione alguma das opções abaixo", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.cancel, style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.message, style: .default, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.unfollow, style: .default, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.blockUser, style: .destructive, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    func assecibilityApple(){
        followButton.titleLabel?.adjustsFontForContentSizeCategory = true
        profileImage.isAccessibilityElement = true
        profileImage.accessibilityTraits = .image
        profileImage.accessibilityLabel = "perfil"
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
