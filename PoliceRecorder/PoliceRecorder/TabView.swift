//
//  TabView.swift
//  PoliceRecorder
//
//  Created by Pranav on 9/19/21.
//

import SwiftUI
 
struct MenuView: View {
    @State private var selection = 1
 
    var body: some View {
            NavigationView {
            TabView(selection: $selection){
                /*SpeechRecognitionView()
                    .tabItem{
                        Label("Speech", systemImage: "mic")
                    }
                */
               
                CameraView()
                    //ContentView()
                    .tabItem{
                        Label("Camera", systemImage: "camera")
                    }
//                LoginView()
//                    .tabItem {
//                        Label("Login", systemImage: "lock")
//                    }
                HomeView(record: false)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(1)
                EmergencyContactsView()
                    .tabItem {
                        Label("Emergency Contacts", systemImage: "staroflife")
                    }
                AddEmergencyContactsView()
                    .tabItem {
                        Label("Add", systemImage: "person.badge.plus")
                    }
            }
            }
        
    }
    
}
