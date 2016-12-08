//
//  FeedVC.swift
//  SocialApp
//
//  Created by RAMIRO AGUIRRE MELENDEZ on 12/8/16.
//  Copyright © 2016 FABATSA. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutBtn(_ sender: Any) {
        let KeyChainResult = KeychainWrapper.defaultKeychainWrapper().removeObjectForKey(KEY_UID)
        print ("ID removed from keychain \(KeyChainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToLogin", sender: nil)
    }
}
