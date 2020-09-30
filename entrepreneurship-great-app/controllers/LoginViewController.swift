//
//  LoginViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 30/09/20.
//

import UIKit
import AuthenticationServices
import CloudKit

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInWithAppleButton(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [.email, .fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension LoginViewController {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            if let name = appleIDCredential.fullName?.givenName,
               let emailAddr = appleIDCredential.email {
                //New user (Signing up).
                //Save this information to CloudKit
                
                //Terminar essa parte quando tiver a tela de cadastro
            } else {
                //Returning user (signing in)
                //Fetch the user name/ email address
                //from private CloudKit
            }
        }
    
        performSegue(withIdentifier: "goToTabViewController", sender: self)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription.description)
    }
}

