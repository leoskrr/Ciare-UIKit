//
//  ProfileViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 12/10/20.
//

import UIKit
import RSKImageCropper
import CloudKit.CKRecord

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate, CustomSegmentedControlDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicheLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var partnershipsQuantity: UILabel!
    @IBOutlet weak var followingQuantity: UILabel!
    @IBOutlet weak var followersQuantity: UILabel!
    
    @IBOutlet weak var myContainer: UIView!
    @IBOutlet weak var midiaKitContainer: UIView!
    @IBOutlet weak var moodBoardContainer: UIView!
    
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var photoChooseButton: UIButton!
    
    var user: UserInfo! {
        didSet{
            DispatchQueue.main.async {
                self.nameLabel.text = self.user.name
                self.nicheLabel.text = self.user.expertiseAreas?[0] ?? ""
                self.partnershipsQuantity.text = "\(self.user.partners?.count ?? 0)"
                self.followingQuantity.text = "\(self.user.following?.count ?? 0)"
                self.followersQuantity.text = "\(self.user.followers?.count ?? 0)"
                if let userImg = self.user.picture {
                    if let userImgUrl = userImg.fileURL {
                        self.profileImage.image = UIImage(contentsOfFile: userImgUrl.path)
                    } else {
                        self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                    }
                } else {
                    self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                }
            }
        }
    }
    
    func change(to index: Int) {
        
        print(index)
        
        switch index {
        
        case 0:
            myContainer.isHidden = false
            midiaKitContainer.isHidden = true
            moodBoardContainer.isHidden = true
            print(index)
        case 1:
            myContainer.isHidden = true
            midiaKitContainer.isHidden = false
            moodBoardContainer.isHidden = true
            print(index)
        case 2:
            midiaKitContainer.isHidden = true
            myContainer.isHidden = true
            moodBoardContainer.isHidden = false
            print(index)
        default:
            break
        }
    }
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: [Translation.Info.my,"MidiaKit","MoodBoard"])
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interfaceSegmented.delegate = self
        
        partnerLabel.text = Translation.Info.partners
        followingLabel.text = Translation.Info.following
        followersLabel.text = Translation.Info.followers
        print()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.followButton.isEnabled = false
        self.followButton.setTitle(Translation.Placeholder.youText, for: .normal)
        loadComponents()
        
        change(to: 0)
    }
    
    func loadComponents(){
        self.nameLabel.text = Translation.Load.loadingText
        self.nicheLabel.text = Translation.Load.loadingText
        self.partnershipsQuantity.text = "0"
        self.followingQuantity.text = "0"
        self.followersQuantity.text = "0"
        
        ListUserInformationService().execute(){
            user, error in
            
            guard let info = user, error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            
            self.user = info
        }
    }
    
    @IBAction func followButtonSelected(_ sender: UIButton) {
        
    }
    
    @IBAction func moreButtonSelected(_ sender: Any) {
        
        let actionSheet = UIAlertController()
        
        actionSheet.addAction(UIAlertAction(title: Translation.Util.cancel, style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title:Translation.Alert.logOut, style: .destructive, handler: {_ in
            
            setUserLoggedInApplicationStatus(false)
            
            
            let newVC = self.storyboard?.instantiateViewController(withIdentifier: "loginView")
            self.definesPresentationContext = true
            newVC?.modalPresentationStyle = .overCurrentContext
            self.present(newVC!, animated: false, completion: nil)
            
            self.tabBarController?.tabBar.isHidden = true
        }))
        
        present(actionSheet, animated: true)
        
    }
    
    
    
    @IBAction func photoChooseSelected(_ sender: Any) {
        
        view.endEditing(true)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: Translation.Photo.source, message: Translation.Photo.chooseSource, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Translation.Post.camera, style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                showAlertError(self, text: Translation.Error.cameraUnavailable)
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: Translation.Post.gallery, style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType
                = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: Translation.Util.cancel, style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image =  info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        picker.dismiss(animated: false, completion: { () -> Void in
            var imageCropVC: RSKImageCropViewController!
            
            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.circle)
            
            imageCropVC.delegate = self
            
            self.present(imageCropVC, animated: true)

        })
    }
}

extension ProfileViewController: RSKImageCropViewControllerDelegate {
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        
        let image = croppedImage
        
        do {
            let path = NSTemporaryDirectory() + "avatar_temp_\(UUID().uuidString).png"
            let url = URL(fileURLWithPath: path)
            
            let imageData = image.pngData()
            
            try imageData?.write(to: url)
            
            let updateUser = user
            updateUser?.picture = CKAsset(fileURL: url)
            
            let resizedImage = image
            
            UIView.transition(with: self.profileImage,
                              duration: 1.0,
                              options: [.curveEaseOut, .transitionCrossDissolve],
                              animations: {
                                self.profileImage.image = resizedImage
                              })
            
            UpdateUserInformationsService().execute(userInfo: updateUser!) { (_, _, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                print("Sucess")
            }
        } catch {
            showAlertError(self, text: Translation.Error.processimage)
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}
