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
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
    
    private var homeViewController: ViewController? {
        return window?.rootViewController as? ViewController
    }

    private func environmentMenu() -> YoshiSubmenu {
        let environmentOptions = [YoshiBaseEnvironment.qa, YoshiBaseEnvironment.production]
        let environmentManager = YoshiEnvironmentManager(environments: environmentOptions) { [weak self] (environment) in
            self?.homeViewController?.updateEnvironment(name: environment.name, url: environment.baseURL)
        }
        return YoshiEnvironmentMenu(environmentManager: environmentManager)
    }

    private func dateSelectorMenu() -> YoshiDateSelectorMenu {
        return DateSelectorMenu(title: "Environment Date",
                                subtitle: nil,
                                didUpdateDate: { (dateSelected) in
                                    NotificationCenter.default.post(name:
                                        NSNotification.Name(rawValue: Notifications.EnvironmentDateUpdatedNotification),
                                                                    object: dateSelected)
        })
    }

    private func instabugMenu() -> YoshiMenu {
        Instabug.start(withToken: "cf779d2e19c0affaad8567a7598e330d", invocationEvents: [.none])
        BugReporting.promptOptionsEnabledReportTypes = [.bug]

        return YoshiActionMenu(title: "Start Instabug",
                               subtitle: nil,
                               completion: {
            Instabug.show()
        })
    }

    private func userAccountIdentifier() -> YoshiMenu {
        return YoshiActionMenu(title: "User Account Identifier (long press to copy)",
                               subtitle: "12345567890",
                               completion: nil)
    }
    
    private func menuWithCustomUI() -> YoshiGenericMenu {
        return CustomUIMenu()
    }

    // MARK: - Yoshi Invocation options
    // Implement the functionality you want!

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        Yoshi.motionBegan(motion, withEvent: event)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesBegan(touches, withEvent: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesMoved(touches, withEvent: event)
    }
}
