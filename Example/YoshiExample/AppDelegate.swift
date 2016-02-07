//
//  AppDelegate.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit
import Yoshi

struct Notifications {
    static let EnvironmentUpdatedNotification = "EnvironmentUpdatedNotification"
    static let EnvironmentDateUpdatedNotification = "EnvironmentDateUpdatedNotification"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        #if DEBUG
            setupDebugMenu()
        #endif
        
        return true
    }

    func setupDebugMenu() {
        // YoshiMenuType.TableView
        let menuItemProd = MenuItem(name: "Production")
        let menuItemStaging = MenuItem(name: "Staging")
        let menuItemQA = MenuItem(name: "QA")
        let environmentItems: [YoshiTableViewMenuItem] = [menuItemProd, menuItemStaging, menuItemQA]

        let tableViewMenu = TableViewMenu(debugMenuName: "Environment",
            displayItems: environmentItems, didSelectDisplayItem: { (displayItem) in
            NSNotificationCenter.defaultCenter()
                .postNotificationName(Notifications.EnvironmentUpdatedNotification, object: displayItem.displayText())
        })

        // YoshiMenuType.DateSelector
        let dateSelector = DateSelector(debugMenuName: "Environment Date", didUpdateDate: { (dateSelected) in
            NSNotificationCenter.defaultCenter()
                .postNotificationName(Notifications.EnvironmentDateUpdatedNotification, object: dateSelected)
        })

        // YoshiMenuType.CustomMenu
        let setup: () -> () = {
            print("setup")
        }

        let completion: () -> () = {
            print("completed")
        }

        let customMenu = CustomMenu(debugMenuName: "Custom", setup: setup, completion: completion)

        let menuItems: [YoshiMenu] = [tableViewMenu, dateSelector, customMenu]

        if #available(iOS 9.0, *) {
            DebugMenu.startWithInvokeEvent(.ForceTouch, menuItems: menuItems)
        } else {
            DebugMenu.startWithInvokeEvent(.ShakeMotion, menuItems: menuItems)
        }
    }
}
