//
//  AppDelegate.swift
//  Reign Challenge
//
//  Created by Martin Regas on 17/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAppCoordinator()
        
        return true
    }

    private func setupAppCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appCordinator = AppCoordinator(window: window)
        self.window = window
        self.appCoordinator = appCordinator
        appCordinator.start()
    }
}

