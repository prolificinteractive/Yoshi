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
        let menuItemProd = MenuItem(name: "Production", selected: false)
        let menuItemStaging = MenuItem(name: "Staging", selected: false)
        let menuItemQA = MenuItem(name: "QA", selected: false)
        let environmentItems: [YoshiTableViewMenuItem] = [menuItemProd, menuItemStaging, menuItemQA]

        let tableViewMenu = TableViewMenu(title: "Environment",
            subtitle: nil,
            displayItems: environmentItems, didSelectDisplayItem: { (displayItem) in
            NSNotificationCenter.defaultCenter()
                .postNotificationName(Notifications.EnvironmentUpdatedNotification, object: displayItem.name)
        })

        // YoshiMenuType.DateSelector
        let dateSelector = DateSelector(title: "Environment Date",
            subtitle: nil,
            didUpdateDate: { (dateSelected) in
            NSNotificationCenter.defaultCenter()
                .postNotificationName(Notifications.EnvironmentDateUpdatedNotification, object: dateSelected)
        })

        Yoshi.setupDebugMenu([tableViewMenu, dateSelector, TestMenuItem()])
    }

    // Implement the functionality you want!

    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        Yoshi.motionBegan(motion, withEvent: event)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Yoshi.touchesBegan(touches, withEvent: event)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Yoshi.touchesMoved(touches, withEvent: event)
    }
}
