//
//  FirebaseAPI.swift
//  Esusu
//
//  Created by William Gu on 5/2/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import Firebase
class FirebaseAPI: NSObject {

    
    static let sharedInstance = FirebaseAPI()

    
    //required to add to end of phone number
    let EMAIL_DOMAIN = "@esusu.com";
    
    let rootRef = Firebase(url:"https://glowing-fire-3895.firebaseio.com/")
    let userRef = Firebase(url:"https://glowing-fire-3895.firebaseio.com/users/")
    let groupRef = Firebase(url:"https://glowing-fire-3895.firebaseio.com/groups/")
    
    //MARK: Validation
    
    func username(phoneNumber: String) -> String {
        let username = phoneNumber + EMAIL_DOMAIN;
        return username;
    }
    
    
    //MARK: Users
    func getUsers() {
        userRef.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
        }, withCancelBlock: { error in
            print(error.description)
        })
    }
    
    func createUser(phoneNumber: String, password: String) {
        
        rootRef.createUser(username(phoneNumber), password: password,
                           withValueCompletionBlock: { error, result in
                            if error != nil {
                                //Error creating account
                            } else {
                                let uid = result["uid"] as? String
                                print("Successfully created user account with uid: \(uid)")
                            }
        })
    }
    
    func updateUser() {
        
    }
    
    func deleteUser(phoneNumber: String, password: String) {
        rootRef.removeUser(username(phoneNumber), password: password) { (error) in
            if error != nil {
                //error with deletion
            } else {
                //user deleted
            }
        }
    }
    
    //MARK: Auth
    func login(phoneNumber: String, password: String) {
        rootRef.authUser(username(phoneNumber), password: password,
                         withCompletionBlock: { error, authData in
                            
                            if error != nil {
                                //Error logging in
                            } else {
                                //logged in!
                            }
        })
    }
    
    //MARK: Groups
    
    func createGroup() {
        
    }
    
    func updateGroup() {
        
    }
    func deleteGroup() {
        
    }
    
    
    
    
    
}
