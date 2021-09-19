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
    @State private var selection = 1
 
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection){
                /*SpeechRecognitionView()
                    .tabItem{
                        Label("Speech", systemImage: "mic")
                    }
                */
               
                CameraView()
                    //ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem{
                        Label("Camera", systemImage: "camera")
                    }
                LoginView()
                    .tabItem {
                        Label("Login", systemImage: "lock")
                    }
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
    class AppDelegate: NSObject, UIApplicationDelegate {
        
        var window: UIWindow?
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          FirebaseApp.configure()
          return true
        }

        func applicationWillResignActive(_ application: UIApplication) {
            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
            // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        }

        func applicationDidEnterBackground(_ application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }

        func applicationWillEnterForeground(_ application: UIApplication) {
            // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }

        func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
      }
}
