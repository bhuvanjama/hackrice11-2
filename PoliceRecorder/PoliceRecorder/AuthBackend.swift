//
//  AuthBackend.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/17/21.
//

import Foundation
import Firebase

var userEmail: String = ""

struct AuthBackend {
    
    func loginAuth(username: String, password: String) {
        
        Auth.auth().signIn(withEmail: username, password: password, completion: { (result, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("User is logged in.")
                print((Auth.auth().currentUser?.email))
                print(username)
                userEmail = username.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
            }
        })
    }
    
    
    
}


