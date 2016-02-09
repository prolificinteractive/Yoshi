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

        let navigationController = UINavigationController()
        let debugViewController = DebugViewController(options: yoshiMenuItems, completion: { [weak self] in
            self?.animate({
                    self?.presentingWindow?.alpha = 0.0
                }, completed: {
                    self?.presentingWindow = nil
            })
        })

        navigationController.setViewControllers([debugViewController], animated: false)

        let window = UIWindow()
        window.rootViewController = navigationController
        window.windowLevel = UIWindowLevelNormal
        presentingWindow = window

        window.makeKeyAndVisible()
        window.alpha = 0.0
        window.rootViewController?.view.layoutIfNeeded()
        animate {
            window.alpha = 1
        }
    }

    private func animate(animations: () -> Void) {
        animate(animations, completed: nil)
    }

    private func animate(animations: () -> Void, completed: ( () -> Void)?) {
        UIView.animateWithDuration(0.3, animations: {
                animations()
            }, completion: { _ in
                completed?()
        })
    }
}
