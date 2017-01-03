//
//  ViewController.swift
//  SocialApp
//
//  Created by RAMIRO AGUIRRE MELENDEZ on 12/7/16.
//  Copyright © 2016 FABATSA. All rights reserved.
//
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper
class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: LoginTextFields!
    @IBOutlet weak var pwdField: LoginTextFields!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.defaultKeychainWrapper().stringForKey(KEY_UID){
            print("KeychainWrapper user found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    @IBAction func facebookbtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self){
            (result, error) in
            if error != nil {
                print("Unable to authenticate facebook - \(error)")
            }else if result?.isCancelled == true {
                print("User cancelled user Authentication")
            }else {
                print("Succesfully Authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase")
            }else{
                print("Succesfully Authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(user.uid, userData: userData)
                }
            }
        })
    }
    
    @IBAction func emailSignInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: {(user, error) in
                if error == nil {
                    print("Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(user.uid, userData: userData)
                    }
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print("Unable to authenticate with Firebase by Email")
                        }else {
                            print("Succesfully authenticated with Firebase by Email")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(_ id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(id, userData: userData)
        let KeyChainResult = KeychainWrapper.defaultKeychainWrapper().setString(id, forKey: KEY_UID)
        print ("Data saved to Keychain \(KeyChainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

