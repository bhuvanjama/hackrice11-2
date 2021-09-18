//
//  PoliceRecorderApp.swift
//  PoliceRecorder
//
//  Created by Siddharth on 9/17/21.
//

import SwiftUI
import Firebase

@main
struct PoliceRecorderApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate


    var body: some Scene {
        WindowGroup {
            RegistrationView()
//                ContentView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            TabView{
//                HomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "square.and.pencil")
//                    }
//
//                LoginView()
//                    .tabItem {
//                        Label("Login", systemImage: "square.and.pencil")
//                    }
//            }
            
        }
    }
    
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          FirebaseApp.configure()
          return true
        }
      }
}
