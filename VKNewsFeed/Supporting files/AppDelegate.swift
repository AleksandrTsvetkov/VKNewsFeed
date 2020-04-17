//
//  AppDelegate.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 15.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import Pods_VKNewsFeed

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {
    
    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.authService = AuthService()
        authService.delegate = self
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: AuthServiceDelegate
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true)
    }
    
    func authServiceSignIn() {
        print(#function)
        let feedVC: FeedViewController = FeedViewController.loadFromStoryboard()
        let navigationVC = UINavigationController(rootViewController: feedVC)
        UIApplication.shared.windows.first?.rootViewController = navigationVC
    }
    
    func authServiceFailedToSignIn() {
        print(#function)
    }
    
}

