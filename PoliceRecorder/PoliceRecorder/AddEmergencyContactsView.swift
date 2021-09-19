//
//  AddEmergencyContactsView.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/18/21.
//

//
//  AddEmergencyContactsView.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/18/21.
//

import SwiftUI
import Firebase

struct AddEmergencyContactsView: View {
    
    @State var emergencyContact = ""
    @State var emergencyNumber = ""
    
    let db = Database.database().reference()
    
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")

    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("1"), Color("1")]), startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Image(systemName: "person").resizable().frame(width: 20, height: 20)
                    TextField("Emergency Contact Name", text: $emergencyContact).padding(.leading, 12).font(.system(size: 20))
                }.padding(12)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.leading, 12)
                .padding(.trailing, 12)
                
                HStack {
                    Image(systemName: "phone").resizable().frame(width: 20, height: 20)
                    TextField("Phone Number", text: $emergencyNumber).padding(.leading, 12).font(.system(size: 20))
                }.padding(12)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.leading, 12)
                .padding(.trailing, 12)
                
                Button(action: {
                    
                    
                   let phoneNumber = (emergencyNumber as NSString).doubleValue
                    
                    let contactInfo = ["name": emergencyContact, "phoneNumber": phoneNumber] as [String : Any]
                    
                    print(emergencyContact + "\(phoneNumber)")
                    print(email!)
                    
                    db.child("Emergency-Contacts").child(email!).child(emergencyContact).setValue(contactInfo)
                    
                    
                }, label: { Text("Add Contact").padding(.leading, 12).font(.system(size: 20))
})
                
            }
        }
    }
}

struct AddEmergencyContactsView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmergencyContactsView()
    }
}

