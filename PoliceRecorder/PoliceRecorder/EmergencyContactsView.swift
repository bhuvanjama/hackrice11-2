//
//  EmergencyContactsView.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/18/21.
//

import SwiftUI
import Firebase

struct EmergencyContactsView: View {
    
    let db = Database.database().reference()
    
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    //@State var namesArray: [String] = []
    
    @ObservedObject private var list = ListofContacts()
    
    
    var body: some View {
        
        VStack {
            List(list.names, id: \.self) { item in
                        HStack {
                            Image("Aura")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 70)
                                .cornerRadius(4)
            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item).fontWeight(.semibold)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            }.onTapGesture {
                                
                                
                                db.child("Emergency-Contacts").child(email ?? "hello-gmail-com").child(item).observeSingleEvent(of: .value, with: { (snapshot) in
                                    
                                    let value = snapshot.value as? NSDictionary
                                    
                                    if let phoneNumber = value?["phoneNumber"] {
                                        if let url = URL(string: "tel://\(phoneNumber)") {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                    
                                })
                                
                                
                            }
                        }
                    }.onAppear {
                        self.list.listofContacts()
                    }
            //add new contact
            NavigationLink(destination: AddEmergencyContactsView()) {
                Text("Add New Contact")
            }
            
        }
        

        
        
    }
}

struct EmergencyContactsView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyContactsView()
    }
}
