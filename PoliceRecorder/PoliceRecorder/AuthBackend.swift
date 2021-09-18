//
//  AuthBackend.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/17/21.
//

import Foundation
import Firebase

struct AuthBackend {
    
    func errorMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
    }
    
    func loginAuth(username: String, password: String) {
        
        Auth.auth().signIn(withEmail: username, password: password, completion: { (result, error) in
            
            if error != nil {
                self.errorMessage(title: "Login Error", message: error!.localizedDescription)
            } else {
                print("User is logged in.")
            }
        })
    }
    
    
    
}


