//
//  TodoFirebaseApp.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/17/21.
//

import Foundation
import SwiftUI
import Firebase

struct TodoFirebaseApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
