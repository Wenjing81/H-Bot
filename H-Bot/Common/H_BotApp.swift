//
//  H_BotApp.swift
//  H-Bot
//
//  Created by Wenjing Zhang on 2021-02-25.
//

import SwiftUI
import Firebase

@main
struct H_BotApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel())
        }
    }
}
