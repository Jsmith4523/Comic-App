//
//  Comic_AppApp.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/22/23.
//

import SwiftUI

@main
struct Comic_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
