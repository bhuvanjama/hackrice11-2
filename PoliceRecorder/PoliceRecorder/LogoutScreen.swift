//
//  LogoutScreen.swift
//  PoliceRecorder
//
//  Created by Bhuvan Jama on 9/18/21.
//

import SwiftUI
import Firebase

struct LogoutScreen: View {
    
    var body: some View {
        ZStack{
            NavigationLink(destination: LoginView()) {
                Text("Logout")
                  
            }
            .onTapGesture {
                
                
                let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
               } catch let signOutError as NSError {
                 print("Error signing out: %@", signOutError)
               }
                
                
            }
    
        }
    }
}

struct LogoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogoutScreen()
    }
}
