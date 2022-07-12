//
//  AppDelegate.swift
//  PCWallbox
//
//  Created by Luis Cañadas Treceño on 6/3/22.
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let (view, navigator) = HomeBuilder().build()
        let navigatorViewController = UINavigationController(rootViewController: UIViewController())
        navigator.view = view
        navigator.navigationController = navigatorViewController

        window?.rootViewController = navigatorViewController
        window?.makeKeyAndVisible()

        navigator.start()

        return true
    }
}
