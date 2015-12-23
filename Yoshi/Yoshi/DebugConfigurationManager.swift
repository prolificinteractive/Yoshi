//
//  DebugConfigurationManager.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal class DebugConfigurationManager: NSObject {

    static let sharedInstance = DebugConfigurationManager()

    var inDebugMenu: Bool = false
    let debugAlertController = UIAlertController(title: "Yoshi Debug", message: nil, preferredStyle: .ActionSheet)
    var yoshiMenuItems = [YoshiMenu]()
    var presentingViewController: UIViewController?

    func setupDebugMenuOptions(menuItems: [YoshiMenu]) {
        self.yoshiMenuItems = menuItems
        var alertActions = [UIAlertAction]()

        for menu in self.yoshiMenuItems {
            switch menu.menuType {
            case .TableView:
                guard let tableViewAction = tableViewAction(menu) else { continue }
                alertActions.append(tableViewAction)
            case .DateSelector:
                print("date Selector")
            case .CustomMenu:
                guard let customMenuAction = customMenuAction(menu) else { continue }
                alertActions.append(customMenuAction)
            }
        }

        for alertAction in alertActions {
            self.debugAlertController.addAction(alertAction)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (alertAction) -> Void in
            self.inDebugMenu = false
        }
        self.debugAlertController.addAction(cancelAction)
    }

    func showDebugActionSheetFromViewController(viewController: UIViewController) {
        self.presentingViewController = viewController
        viewController.presentViewController(self.debugAlertController, animated: true, completion: nil)
        self.inDebugMenu = true
    }

    func tableViewAction(menu: YoshiMenu) -> UIAlertAction? {
        guard let menu = menu as? YoshiTableViewMenu else { return nil }
        let alertAction = UIAlertAction(title: menu.debugMenuName, style: .Default) { (_) -> Void in
            let bundle = NSBundle(forClass: DebugConfigurationManager.self)
            let tableViewController = DebugTableViewController(nibName: DebugTableViewController.nibName(), bundle: bundle)
            tableViewController.modalPresentationStyle = .FullScreen
            tableViewController.setup(menu)
            guard let presentingViewController = self.presentingViewController else { return }
            presentingViewController.presentViewController(tableViewController, animated: true, completion: { () -> Void in
                self.inDebugMenu = false
            })
        }
        return alertAction
    }

    func customMenuAction(menu: YoshiMenu) -> UIAlertAction? {
        guard let menu = menu as? YoshiCustomMenu else { return nil }
        menu.setup()
        return UIAlertAction(title: menu.debugMenuName, style: .Default) { (_) -> Void in
            menu.completion()
            self.inDebugMenu = false
        }
    }
}
