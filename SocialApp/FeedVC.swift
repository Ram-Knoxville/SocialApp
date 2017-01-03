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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print(snapshot.value!)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("snap: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    @IBAction func signOut(_ sender: Any) {
        let KeyChainResult = KeychainWrapper.defaultKeychainWrapper().removeObjectForKey(KEY_UID)
        print ("ID removed from keychain \(KeyChainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToLogin", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print("Ram: \(post.caption)")
        
        return tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
    }
    
}
