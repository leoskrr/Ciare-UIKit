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
    
    @IBAction func followButtonSelected(_ sender: UIButton) {
        
        if sender.titleLabel?.text == Translation.Placeholder.btnFollow{
            sender.setTitle("Ask for partnership", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            sender.layer.borderColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.layer.borderWidth = 1
        } else if sender.titleLabel?.text == "Ask for partnership"{
            sender.setTitle("Asked partnership", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        } else if sender.titleLabel?.text == "Asked partnership" {
            sender.setTitle("Ask for partnership", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            sender.layer.borderColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
            sender.layer.borderWidth = 1
            
        }
        
        
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
        
        actionSheet.addAction(UIAlertAction(title: Translation.Alert.unfollow, style: .default, handler: {_ in
            self.followButton.setTitle(Translation.Placeholder.btnFollow, for: .normal)
            self.followButton.backgroundColor = #colorLiteral(red: 0.9505110383, green: 0.9506440759, blue: 0.9504690766, alpha: 1)
            self.followButton.layer.borderWidth = 0
            self.followButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }))
        
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
