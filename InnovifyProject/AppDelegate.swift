//
//  AppDelegate.swift
//  SpeedLocator
//
//  Created by nisha rani on 17/06/17.
//  Copyright © 2017 nisha rani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var timer: Timer?
    var databasePathh: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Database()
        createTable()
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

extension AppDelegate {
    
    func Database() {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        var url = URL(string: docDir)
        url = url?.appendingPathComponent("DBTrack.db")
        databasePathh = "\(url!)"
    }

    func createTable(){
        
        let contactDB = FMDatabase(path: databasePathh)
        if (contactDB == nil){
            print("Error: \(String(describing: contactDB?.lastErrorMessage()))")
        }
        
        if (contactDB?.open())! {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS Track(ID INTEGER PRIMARY KEY AUTOINCREMENT,TRACKING_DATA TEXT)"
            if !(contactDB?.executeStatements(sql_stmt))!{
                print("Error: \(String(describing: contactDB?.lastErrorMessage()))")
            }
            contactDB?.close()
        }else {
            print("Error: \(String(describing: contactDB?.lastErrorMessage()))")
        }
    }
    
    func insertDataToDatabase(trackingData:String){
        
        let contactDB = FMDatabase(path:databasePathh)
        if (contactDB?.open())! {
            
            let insertSQL = "INSERT INTO Track(TRACKING_DATA) VALUES('\(trackingData)')"
            print("insertSQL...%@",insertSQL)
            let result = contactDB?.executeUpdate(insertSQL, withArgumentsIn: nil)
            if !result! {
                print("Error not inserted: \(String(describing: contactDB?.lastErrorMessage()))")
            }else {
                
                
            }
        }else {
            print("Error: \(String(describing: contactDB?.lastErrorMessage()))")
        }
        
    }
}

