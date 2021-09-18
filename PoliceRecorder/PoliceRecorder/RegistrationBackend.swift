//
//  RegistrationBackend.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/17/21.
//

import Foundation
import Firebase

struct RegistrationBackend {
    
    let db = Firestore.firestore()
    
    func registerUser(name: String, phNumber: String, email: String, password: String, confirmPassword: String) {
        
        let phoneNumber = (phNumber as NSString).doubleValue
        
        if password != confirmPassword {
            print("Passwords are not matching. Try again.")
        } else {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
                
                if error != nil {
                    print("Error occurred: " + error!.localizedDescription)
                } else {
                    
                    var userInfo = [String:Any]()
                    userInfo = ["name": name, "email": email, "phoneNumber": phoneNumber, "UUID": UIDevice.current.identifierForVendor!.uuidString]
                    
                    db.collection("users").addDocument(data: userInfo, completion: { (error) in
                        
                        if error != nil {
                            print("Error occurred: " + error!.localizedDescription)
                        } else {
                            
                            let alert = UIAlertController(title: "Success!", message: "We successfully registered you on our database.", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Great!", style: .default, handler: nil)
                            alert.addAction(action)
                            
                            //just a cool touch I wanted to try :D
                            
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.prepare()
                            generator.impactOccurred(intensity: 0.7)
                            
                        }
                        
                    })
                    
                }
                
            })

        }
        
        
    }
    
    
}
