//
//  AppDelegate.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import Yoshi

struct Notifications {
    static let EnvironmentUpdatedNotification = "EnvironmentUpdatedNotification"
    static let EnvironmentDateUpdatedNotification = "EnvironmentDateUpdatedNotification"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        #if DEBUG
            setupDebugMenu()
        #endif

        return true
    }

    func setupDebugMenu() {
        var menu = [YoshiMenu]()

        menu.append(environmentMenu())
        menu.append(dateSelectorMenu())
        menu.append(instabugMenu())
        menu.append(userAccountIdentifier())

        Yoshi.setupDebugMenu(menu)
    }

    private func environmentMenu() -> YoshiTableViewMenu {
        let production = MenuItem(name: "Production")
        let staging = MenuItem(name: "Staging")
        let qa = MenuItem(name: "QA", selected: true)

        let environmentItems: [YoshiTableViewMenuItem] = [production, staging, qa]

        return TableViewMenu(title: "Environment",
                             subtitle: nil,
                             displayItems: environmentItems,
                             didSelectDisplayItem: { (displayItem) in
                                NotificationCenter.default
                                    .post(name:
                                        NSNotification.Name(rawValue: Notifications.EnvironmentUpdatedNotification),
                                        object: displayItem.name)
        })
    }

    private func dateSelectorMenu() -> YoshiDateSelectorMenu {
        return DateSelector(title: "Environment Date",
                            subtitle: nil,
                            didUpdateDate: { (dateSelected) in
                                NotificationCenter.default
                                    .post(name:
                                        NSNotification.Name(rawValue: Notifications.EnvironmentDateUpdatedNotification),
                                        object: dateSelected)
        })
    }

    private func instabugMenu() -> YoshiMenu {
        Instabug.start(withToken: "cf779d2e19c0affaad8567a7598e330d", invocationEvent: .none)
        Instabug.setDefaultInvocationMode(.bugReporter)

        return CustomMenu(title: "Start Instabug",
                          subtitle: nil,
                          completion: {
            Instabug.invoke()
        })
    }

    private func userAccountIdentifier() -> YoshiMenu {
        return CustomMenu(title: "User Account Identifier (long press to copy)",
                          subtitle: "12345567890",
                          completion: nil)
    }


    // MARK: - Yoshi Invocation options
    // Implement the functionality you want!

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        Yoshi.motionBegan(motion, withEvent: event)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesBegan(touches, withEvent: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesMoved(touches, withEvent: event)
    }
}
