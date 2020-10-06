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
}

extension LoginViewController {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential{
            if let name = appleIdCredential.fullName,
               let email = appleIdCredential.email {
                let registerViewController = RegisterViewController()
                
                registerViewController.userName = "\(name)"
                registerViewController.userEmail = email

                let segue: UIStoryboardSegue = .init(identifier: "goToRegisterVC", source: self, destination: registerViewController)
                
                prepare(for: segue, sender: self)
                
            } else {
                SignInUserService().execute() { response, user, error in
                    switch response {
                        case .SendUserToFeed:
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "goToTabViewController", sender: self)
                            }
                        case .SendUserToRegister:
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "goToRegisterVC", sender: self)
                            }
                        case .Error:
                            print(error!)
                    }
                }
            }
        }
    }
}

