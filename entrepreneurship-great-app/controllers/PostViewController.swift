//
//  PostViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 08/10/20.
//

import UIKit
import CloudKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var nicheLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var pickerImageButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    var imageUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera not available")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType
                = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image =  info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let imageData = image.pngData()
        
        postImage.image = image
        
        do {
            let path = NSTemporaryDirectory() + "avatar_temp_\(UUID().uuidString).png"
            let url = URL(fileURLWithPath: path)

            try imageData?.write(to: url)
            
            imageUrl = url
        } catch {
            print("Error writing avatar to temporary directory: \(error)")
        }
        
        picker.dismiss(animated: true, completion: nil )
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButtonTouchedUp(_ sender: UIButton) {
        guard let description = descriptionTextView.text else {
            print("Error: missing description")
            return
        }
        
        guard let imgUrl = imageUrl else {
            print("Error: missing image url")
            return
        }
        
        let userRecordName = getUserRecordNameFromUserDefaults()
        
        guard let recordName = userRecordName else {
            print("Error: missing record name")
            return
        }
        
        let userId = CKRecord.ID(recordName: recordName)
        
        let post = Post(author_id: CKRecord.Reference(recordID: userId, action: .none), description: description, image: CKAsset(fileURL: imgUrl))
        
        CreatePostService().execute(post: post) {
            response, createdPost, error in
            
            switch response {
            case .success:
                print("Post criado com sucesso!")
            case .failed:
                print("Erro ao criar post: \(error!)")
            }
        }
    }
}
