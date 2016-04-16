//
//  DebugConfigurationManager.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

/// The configuration manager for the debug menu.
internal final class YoshiConfigurationManager {

    /// The default instance.
    static let sharedInstance = YoshiConfigurationManager()

    private var yoshiMenuItems = [YoshiMenu]()
    private var presentingWindow: UIWindow?

    /**
     Sets the debug options to use for presenting the debug menu.

     - parameter menuItems: The menu items for presentation.
     */
    func setupDebugMenuOptions(menuItems: [YoshiMenu]) {
        yoshiMenuItems = menuItems
    }

    /**
     Invokes the display of the debug menu.
     */
    func showDebugActionSheet() {
        guard presentingWindow == nil else {
            return
        }

        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.windowLevel = UIWindowLevelNormal

        // Use a dummy view controller with clear background.
        // This way, we can make the actual view controller we want to present a form sheet on the iPad.
        let rootViewController = UIViewController()
        rootViewController.view.backgroundColor = UIColor.clearColor()

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        presentingWindow = window

        // iOS doesn't like when modals are presented right away after a window's been made key and visible.
        // We need to delay presenting the debug controller a bit to suppress the warning.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.presentDebugViewController()
        }
    }

    private func presentDebugViewController() {
        if let rootViewController = presentingWindow?.rootViewController {
            let navigationController = UINavigationController()
            let debugViewController = DebugViewController(options: yoshiMenuItems,
                completion: { [weak self]  completionBlock in
                rootViewController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self?.presentingWindow = nil
                    completionBlock?()
                })
            })

            navigationController.modalPresentationStyle = .FormSheet
            navigationController.setViewControllers([debugViewController], animated: false)

            rootViewController.presentViewController(navigationController, animated: true, completion: nil)
        }
    }
}
