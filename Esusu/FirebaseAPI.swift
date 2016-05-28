//
//  FirebaseAPI.swift
//  Esusu
//
//  Created by William Gu on 5/2/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import Firebase

protocol FirebaseAPIDelegate {
    func loginError(error: NSError)
    func loginSuccess(authData: AnyObject)
}


class FirebaseAPI: NSObject {

    
    static let sharedInstance = FirebaseAPI()
    var delegate: FirebaseAPIDelegate?
    var currentSessionUID: String?
    
    //required to add to end of phone number
    let EMAIL_DOMAIN = "@esusu.com";
    
    let rootRef = Firebase(url:"https://flickering-torch-7464.firebaseio.com/")
    let userRef = Firebase(url:"https://flickering-torch-7464.firebaseio.com/users/")
    let groupRef = Firebase(url:"https://flickering-torch-7464.firebaseio.com/groups/")
    
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
    
    func createUser(phoneNumber: String, password: String, fullName: String) {
        
        let userData = ["fullName": fullName,
                        "phoneNumber": phoneNumber,
                        "verified": false];
        
        rootRef.createUser(username(phoneNumber), password: password,
                           withValueCompletionBlock: { error, result in
                            if error != nil {
                                //TODO: Warn about duplicate number creation
                                //Error creating account
                                print("Error: \(error)");
                            } else {
                                let uid = result["uid"] as? String
                                self.currentSessionUID = uid;
                                print("Successfully created user account with uid: \(uid)")
                                
                                self.updateUser(uid!, user: userData);
                            }
        })
    }
    
    func updateUser(userID: String, user: NSDictionary) {
        let thisUserRef = userRef.childByAppendingPath(userID);
        thisUserRef.updateChildValues(user as [NSObject : AnyObject]);
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
                                self.delegate?.loginError(error);
                            } else {
                                //logged in!
                                self.delegate?.loginSuccess(authData);
                            }
        })
    }
    
    func logout() {
        rootRef.unauth();
    }
    
    func checkLoginStatus() -> Bool {
        if rootRef.authData != nil {
            // user authenticated
            print(rootRef.authData) //Contains .uid
            return true;
        } else {
            // No user is signed in
            return false;
        }
    }
    
    //MARK: Groups
    
    func createGroup(name: String, paymentSchedule: String, members: NSMutableArray, ids: NSMutableArray) {
        let uuid = NSUUID().UUIDString
        let dateCreated = NSDate().timeIntervalSince1970;
        
        let currentUserId = self.rootRef.authData.uid
        
        let group = ["name": name,
                     "paymentSchedule":paymentSchedule,
                     "members":members,
                     "ids": ids,
                     "admin": currentUserId,
                     "createdDate": dateCreated];
        
        let thisGroupRef = groupRef.childByAppendingPath(uuid)
        thisGroupRef.setValue(group);

        //TODO: Save newly created groups to user ids
        //FOR all userids add them to groups

    }
    
    func updateGroup() {
        
    }
    func deleteGroup() {
        
    }
    
    
    
    
    
}
