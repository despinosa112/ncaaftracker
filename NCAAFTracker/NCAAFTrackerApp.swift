//
//  NCAAFTrackerApp.swift
//  NCAAFTracker
//
//  Created by Daniel Espinosa on 10/3/22.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct NCAAFTrackerApp: App {
    
    @StateObject private var dataLoader = DataLoader()
        
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataLoader)
        }
    }
}
