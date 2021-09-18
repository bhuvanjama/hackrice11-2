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
            TabView{
                SpeechRecognitionView()
                    .tabItem{
                        Label("Speech Shit", systemImage: "square.and.pencil")
                    }
                
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem{
                        Label("Content", systemImage: "square.and.pencil")
                    }
                
                HomeView(record: false)
                    .tabItem {
                        Label("Home", systemImage: "square.and.pencil")
                    }
 
                LoginView()
                    .tabItem {
                        Label("Login", systemImage: "square.and.pencil")
                    }
                EmergencyContactsView()
                    .tabItem {
                        Label("ECV", systemImage: "square.and.pencil")
                    }
                AddEmergencyContactsView()
                    .tabItem {
                        Label("Add", systemImage: "square.and.pencil")
                    }
            }
            
        }
    }
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          FirebaseApp.configure()
          return true
        }
      }
}
