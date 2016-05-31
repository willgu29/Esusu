//
//  FirebaseAPI.swift
//  Esusu
//
//  Created by William Gu on 5/2/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

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
    
    
    let rootRef = FIRDatabase.database().reference()
    let USER_ROUTE = "users/";
    let GROUP_ROUTE = "groups/";
   
 

    //MARK: Validation
    
    func username(phoneNumber: String) -> String {
        let username = phoneNumber + EMAIL_DOMAIN;
        return username;
    }
    
    
    //MARK: Users
    func getUsers() {
        rootRef.child(USER_ROUTE).observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
        }, withCancelBlock: { error in
            print(error.description)
        })
    }
    
    func createUser(phoneNumber: String, password: String, fullName: String) {
        
        let userData = ["fullName": fullName,
                        "phoneNumber": phoneNumber,
                        "verified": false];
        
        FIRAuth.auth()?.createUserWithEmail(username(phoneNumber), password: password) { (user, error) in
            // ...
            if error != nil {
                //TODO: Warn about duplicate number creation
                //Error creating account
                print("Error: \(error)");
            } else {
                let uid = user?.uid
                self.currentSessionUID = uid;
                print("Successfully created user account with uid: \(uid)")
                
                self.updateUser(uid!, user: userData);
            }

        }
     
    }
    
    func updateUser(userID: String, user: NSDictionary) {
        let thisUserRef = rootRef.child(USER_ROUTE+(userID));
        thisUserRef.updateChildValues(user as [NSObject : AnyObject]);
    }
    
    func deleteUser() {
        let user = FIRAuth.auth()?.currentUser
        
        user?.deleteWithCompletion { error in
            if let error = error {
                // An error happened.
                print(error);
            } else {
                // Account deleted.
            }
        }
    }
    
    //MARK: Auth
    func login(phoneNumber: String, password: String) {
        
        FIRAuth.auth()?.signInWithEmail(username(phoneNumber), password: password) { (user, error) in
            // ...
            if error != nil {
                //Error logging in
                self.delegate?.loginError(error!);
            } else {
                //logged in!
                self.delegate?.loginSuccess(user!);
            }
        }
      
    }
    
    func logout() {
        try! FIRAuth.auth()!.signOut()
    }
    
    
    //MARK: Groups
    
    func createGroup(name: String, paymentSchedule: String, members: NSMutableArray, ids: NSMutableArray) {
        let uuid = NSUUID().UUIDString
        let dateCreated = NSDate().timeIntervalSince1970;
        let currentUserId = FIRAuth.auth()?.currentUser!.uid

        
        let group: [String: AnyObject] = ["name": name,
                                    "paymentSchedule":paymentSchedule,
                                    "members":members,
                                    "ids": ids,
                                    "admin": currentUserId!,
                                    "createdDate": dateCreated];
        
        let thisGroupRef = rootRef.child(GROUP_ROUTE+uuid);
        thisGroupRef.setValue(group);

        //TODO: Save newly created groups to user ids
        //FOR all userids add them to groups

    }
    
    func updateGroup() {
        
    }
    func deleteGroup() {
        
    }
    
    
    
    
    
}
