//
//  PostViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 08/10/20.
//

import UIKit
import CloudKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var nicheLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var pickerImageButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    var shouldLoadDynamicData = true
    
    var user: UserInfo? = nil {
        didSet {
            DispatchQueue.main.async {
                self.companyNameLabel.text = self.user?.name
                self.nicheLabel.text = self.user?.expertiseAreas?[0]
                if let userImage = self.user?.picture {
                    if let userImageUrl = userImage.fileURL {
                        self.profileImage.image = UIImage(contentsOfFile: userImageUrl.path)
                    } else {
                        self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                    }
                } else {
                    self.profileImage.image = UIImage(named: "defaultUserProfileImage")
                }
            }
        }
    }
    
    var imageUrl: URL?
    let placeholder = Translation.Post.description
    let userRecordName = getUserInfoRecordNameFromUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapOutsideTextView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapOutsideTextView)
        
        descriptionTextView.delegate = self
        postButton.setTitle(Translation.Post.textButtonPost, for: .normal)
        cleanButton.setTitle(Translation.Alert.clean, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.descriptionTextView.text = placeholder
        self.descriptionTextView.textColor = UIColor(named: "PlaceholderRegister")
        drawTextView()
        
        if shouldLoadDynamicData {
            self.nicheLabel.text = Translation.Load.loadingText
            self.companyNameLabel.text = Translation.Load.loadingText
            self.profileImage.image = UIImage(named: "defaultUserProfileImage")

            loadUser()
        }
    }
    
    func loadUser(){
        ListUserInformationService().execute(){
            info, error in
            
            self.shouldLoadDynamicData = false
            
            guard let userInfos = info, error == nil else {
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
                return
            }
            self.user = userInfos
        }
    }
    
    func drawTextView(){
        descriptionTextView.text = placeholder
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        drawTextView()
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        view.endEditing(true)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
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
        
        var selectedImage: UIImage?
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = editedImage
        }
        
        guard let image = selectedImage else {
            return
        }
                
        do {
            let path = NSTemporaryDirectory() + "avatar_temp_\(UUID().uuidString).png"
            let url = URL(fileURLWithPath: path)
            
            let imageData = image.pngData()
            
            try imageData?.write(to: url)
            
            imageUrl = url
                        
            let resizedImage = image
            
            UIView.transition(with: self.postImage,
                              duration: 1.0,
                              options: [.curveEaseOut, .transitionCrossDissolve],
                              animations: {
                                self.postImage.image = resizedImage
                              })
        } catch {
            showAlertError(self, text: Translation.Error.processimage)
        }
        
        picker.dismiss(animated: true, completion: nil )
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButtonTouchedUp(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let description = descriptionTextView.text else {
            showAlertError(self, text: Translation.Error.postDescription)
            return
        }
        
        guard let imgUrl = imageUrl else {
            showAlertError(self, text: Translation.Error.postimage)
            return
        }
        
        guard let recordName = userRecordName else {
            showAlertError(self, text: Translation.Error.server)
            return
        }
        
        let userId = CKRecord.ID(recordName: recordName)
        
        let post = Post(author_id: CKRecord.Reference(recordID: userId, action: .none), description: description, image: CKAsset(fileURL: imgUrl))
        
        showLoadingOnViewController(self)
        
        CreatePostService().execute(post: post) {
            response, createdPost, error in
            
            DispatchQueue.main.async {
                removeLoadingOnViewController(self)
            }

            switch response {
            case .success:
                DispatchQueue.main.async {
                    showSuccessAlert(self, text: Translation.Success.createdPost)
                    self.descriptionTextView.text = nil
                    self.postImage.image = nil
                }
            case .failed:
                DispatchQueue.main.async {
                    showAlertError(self, text: Translation.Error.server)
                }
            }
        }
    }
    
    @IBAction func cleanButton(_ sender: Any) {
        descriptionTextView.text = placeholder
        descriptionTextView.textColor = UIColor(named: "PlaceholderRegister")
        postImage.image = .none
        descriptionTextView.endEditing(true)
    }
}

extension PostViewController {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(named: "PlaceholderRegister") {
            textView.text = ""
            textView.textColor = UIColor(named: "Text")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor(named: "PlaceholderRegister")
        }
    }
}
