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
        var menu = [YoshiGenericMenu]()

        menu.append(environmentMenu())
        menu.append(dateSelectorMenu())
        menu.append(instabugMenu())
        menu.append(userAccountIdentifier())
        menu.append(menuWithCustomUI())

        Yoshi.setupDebugMenu(menu)
    }
    
    /// Deprecated Environment menu usage.
    private func deprecatedEnvironmentMenu() -> YoshiSubmenu {
        
        var environmentItems = [SubviewMenuItem]()
        
        let itemSelected: (SubviewMenuItem) -> Void = { item in
            environmentItems.forEach{ $0.selected = false }
            item.selected = true
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: Notifications.EnvironmentUpdatedNotification),
                                            object: item.title)
        }
        
        let production = SubviewMenuItem(title: "Production", subtitle: "https://mobile-api.com", action: itemSelected)
        let staging = SubviewMenuItem(title: "Staging", subtitle: "https://staging.mobile-api.com", action: itemSelected)
        let qa = SubviewMenuItem(title: "QA", subtitle: "http://qa.mobile-api.com", selected: true, action: itemSelected)

        environmentItems = [production, staging, qa]

        return Submenu(title: "Environment",
                       options: environmentItems,
                       dynamicSubtitle: { environmentItems.filter{ $0.selected }.first?.title })
    }
    
    private func environmentMenu() -> YoshiSubmenu {
        
        var environmentSelections = [YoshiSingleSelection]()
        
        let production = YoshiSingleSelection(title: "Production", subtitle: "https://mobile-api.com")
        let staging = YoshiSingleSelection(title: "Staging", subtitle: "https://staging.mobile-api.com")
        let qa = YoshiSingleSelection(title: "QA", subtitle: "http://qa.mobile-api.com")
        
        environmentSelections = [production, staging, qa]
        
        return YoshiSingleSelectionMenu(title: "Environment",
                                        options: environmentSelections,
                                        selectedIndex: 0,
                                        didSelect: { selection in
                                            NotificationCenter.default.post(name:NSNotification.Name(rawValue: Notifications.EnvironmentUpdatedNotification),
                                                                            object: selection.title)
        })
    }

    private func dateSelectorMenu() -> YoshiDateSelectorMenu {
        return DateSelectorMenu(title: "Environment Date",
                                subtitle: nil,
                                didUpdateDate: { (dateSelected) in
                                    NotificationCenter.default.post(name:
                                        NSNotification.Name(rawValue: Notifications.EnvironmentDateUpdatedNotification),object: dateSelected)
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
    private func menuWithCustomUI() -> YoshiGenericMenu {
        return CustomUIMenu()
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
