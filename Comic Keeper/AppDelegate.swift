//
//  AppDelegate.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/6/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let collectionNavigationIndex = 0
    let seriesTableIndex = 0
    let issuesTableIndex = 1

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Dependency Injection :)
        // When the app launches inject ComicBookCollection data into each top level view controller
        // (Which in turn will inject ComicBookCollection data into each lower level view controller)
        
        let tabController = window!.rootViewController as! UITabBarController
        let comicBookCollection = ComicBookCollection.createComicBookCollection()
        
        if let tabViewControllers = tabController.viewControllers {
            
            // Collection Tab View Controller
            
            let seriesNavigationViewController = tabViewControllers[collectionNavigationIndex] as! UINavigationController
            
            // Series Table View Controller
            
            let seriesTableViewController = seriesNavigationViewController.viewControllers[seriesTableIndex] as! SeriesTableViewController
            seriesTableViewController.comicBookCollection = comicBookCollection
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

