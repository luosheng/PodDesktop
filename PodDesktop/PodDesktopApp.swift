//
//  PodDesktopApp.swift
//  PodDesktop
//
//  Created by Luo Sheng on 2021/9/7.
//

import SwiftUI

@main
struct PodDesktopApp: App {
    
    @StateObject var globalStore = GlobalStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalStore)
        }
        .commands {
            SidebarCommands()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
    }
}
