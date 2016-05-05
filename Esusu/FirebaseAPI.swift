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

    var rootRef = Firebase(url:"https://glowing-fire-3895.firebaseio.com/")
    var userRef = Firebase(url:"https://glowing-fire-3895.firebaseio.com/users/")
    
    
    func getUsers() {
        rootRef.childByAppendingPath("users/");
    }
    
    func saveUser() {
        
    }
    
    func updateUser() {
        
    }
    
    
    
}
