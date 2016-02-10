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

        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .FormSheet

        let window = UIApplication.sharedApplication().keyWindow
        guard var rootViewController = window?.rootViewController else {
            return
        }

        if let presentedViewController = rootViewController.presentedViewController {
            rootViewController = presentedViewController
        }

        let debugViewController = DebugViewController(options: yoshiMenuItems, completion: {
            navigationController.dismissViewControllerAnimated(true, completion: nil)
            })

        navigationController.setViewControllers([debugViewController], animated: false)

       rootViewController
            .presentViewController(navigationController, animated: true, completion: nil)
    }
}
