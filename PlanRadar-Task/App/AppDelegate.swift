//
//  AppDelegate.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        
        return true
    }
    
    // MARK: - Methods
    
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewcontroller = RootRouter.root.destinationViewController
        window?.makeKeyAndVisible()
        window?.rootViewController = viewcontroller
    }
}

