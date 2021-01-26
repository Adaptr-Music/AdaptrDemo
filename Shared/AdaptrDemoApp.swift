//
//  AdaptrDemoApp.swift
//  Shared
//
//  Created by Arveen kumar on 07/01/2021.
//
//

import SwiftUI
import Adaptr

@main
struct AdaptrDemoApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate;
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }


}
