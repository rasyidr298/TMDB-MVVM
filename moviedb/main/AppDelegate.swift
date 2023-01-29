//
//  AppDelegate.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import UIKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: HomeVC())
    
    window?.makeKeyAndVisible()
    
    NFX.sharedInstance().start()
    
    return true
  }

}

