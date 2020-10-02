//
//  LoginViewController.swift
//  entrepreneurship-great-app
//
//  Created by Vinicius Alencar on 30/09/20.
//

import UIKit
import AuthenticationServices
import CloudKit

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @IBOutlet weak var stackViewForAppleIDButton: UIStackView!
    
    override func viewDidLoad() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)

        self.stackViewForAppleIDButton.addArrangedSubview(authorizationButton)

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [.email, .fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
//    @IBAction func signInWithAppleButton(_ sender: Any) {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//
//        let request = appleIDProvider.createRequest()
//
//        request.requestedScopes = [.email, .fullName]
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//
//        authorizationController.delegate = self
//        //authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
}

extension LoginViewController {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential{
            let userIdentifier = appleIdCredential.user
            
            if let name = appleIdCredential.fullName,
               let email = appleIdCredential.email {
                print("\n\nSIGN UP\n\n")
            } else {
                print("\n\nSIGN IN\n\n")
                SignInUserService().execute(userId: userIdentifier)
            }
            
        }
            //SIGN UP
            
            
            
            //SALVAR DADOS NO BANCO
        
    }
    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//
//        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
//            print("\n\n")
//            print(appleIDCredential.user)
//            print("\n\n")
//
//            let userID = appleIDCredential.user
//            print(userID)
//            if let name = appleIDCredential.fullName?.givenName,
//               let emailAddr = appleIDCredential.email {
//                //New user (Signing up).
//                //Save this information to CloudKit
//                print("SIGN UP")
//                performSegue(withIdentifier: "goToRegisterVC", sender: self)
////                do {
////                    try SignUpUserService().execute(userId: userID, name: name, email: emailAddr)
////                } catch {
////                    print(error)
////                }
//
//                //Terminar essa parte quando tiver a tela de cadastro
//            } else {
//                //Returning user (signing in)
//                print("SIGN IN")
//                print(userID)
//                SignInUserService().execute(userId: userID)
//                performSegue(withIdentifier: "goToTabViewController", sender: self)
//                //Fetch the user name/ email address
//                //from private CloudKit
//            }
//        }
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print(error.localizedDescription.description)
//    }
}

