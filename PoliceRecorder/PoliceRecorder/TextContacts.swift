//
//  TextContacts.swift
//  PoliceRecorder
//
//  Created by Bhuvan Jama on 9/18/21.
//

import Foundation
import Firebase

struct TextContacts {
    
    let ref = Database.database().reference()
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    
    func sendText(){
        
        self.ref.child("Emergency-Contacts").child(email ?? "hello-gmail-com").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let phoneNumber = value?["phoneNumber"] as? Int
            
            let sms: String = "sms:\(String(describing: phoneNumber))&body=\("In Trouble")"
            let strURL: String = sms.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!
            UIApplication.shared.open(URL.init(string: strURL)!,options: [:], completionHandler: nil)
        })
    }
}


