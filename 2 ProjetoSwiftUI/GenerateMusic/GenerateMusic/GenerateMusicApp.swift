//
//  GenerateMusicApp.swift
//  GenerateMusic
//
//  Created by test on 22/10/23.
//

import SwiftUI
import Firebase

@main
struct GenerateMusicApp: App {
    init() {
        FirebaseApp.configure()
        
        try! Auth.auth().signOut()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
