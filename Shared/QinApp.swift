//
//  QinApp.swift
//  Shared
//
//  Created by 林少龙 on 2020/8/6.
//

import SwiftUI

@main
struct QinApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate

    @StateObject var store = Store.shared
    @StateObject var player = Player.shared
    let context = DataManager.shared.context()

    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
                .onAppear {
                    store.dispatch(.loginRefreshRequest)
                }
                .environmentObject(store)
                .environmentObject(player)
                .environment(\.managedObjectContext, context)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .commands {
            SidebarCommands()
        }
        #else
        WindowGroup {
            ContentView()
                .onAppear {
                    store.dispatch(.loginRefreshRequest)
                }
                .environmentObject(store)
                .environmentObject(player)
                .environment(\.managedObjectContext, context)
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .active:
                AudioSessionManager.shared.active()
            case .background:
                break
            case .inactive:
                break
            @unknown default:
                break
            }
        }
        #endif
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AudioSessionManager.shared.configuration()
        return true
    }
}
