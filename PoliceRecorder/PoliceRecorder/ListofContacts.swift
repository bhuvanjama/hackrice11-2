//
//  ListofContacts.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/18/21.
//

import Foundation
import Firebase
import SwiftUI

var namesArray: [String] = []

class ListofContacts: ObservableObject {
    
    let db = Database.database().reference()
    @Published var names = [String]()

    
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    
    func listofContacts() {
        
        
        db.child("Emergency-Contacts").child(email ?? "hello-gmail-com").observe(.childAdded, with: { (snapshot) in
            
            if self.names.contains(snapshot.key) == false {
                self.names.append(snapshot.key)
            }
            namesArray = self.names
        
        })
        
    }
    
}

