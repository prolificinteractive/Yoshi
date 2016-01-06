//
//  DebugConfigurationManager.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal class DebugConfigurationManager {

    static let sharedInstance = DebugConfigurationManager()

    var currentDate = NSDate()
    var inDebugMenu: Bool = false
    let debugAlertController = UIAlertController(title: AppBundleUtility.appVersionText(), message: nil, preferredStyle: .ActionSheet)
    var yoshiMenuItems = [YoshiMenu]()
    var rootViewController: UIViewController?

    func setupDebugMenuOptions(menuItems: [YoshiMenu]) {
        self.yoshiMenuItems = menuItems

        for menu in self.yoshiMenuItems {
            switch menu {
            case let menuType as YoshiTableViewMenu:
                let tableViewAction = self.tableViewAction(menuType)
                self.debugAlertController.addAction(tableViewAction)
            case let menuType as YoshiDateSelectorMenu:
                let datePickerAction = self.dateSelectorAction(menuType)
                self.debugAlertController.addAction(datePickerAction)
            case let menuType as YoshiCustomMenu:
                let customMenuAction = self.customMenuAction(menuType)
                self.debugAlertController.addAction(customMenuAction)
            default:
                continue
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (alertAction) -> Void in
            self.inDebugMenu = false
        }
        self.debugAlertController.addAction(cancelAction)
    }

    func showDebugActionSheetFromViewController(viewController: UIViewController) {
        self.rootViewController = viewController
        viewController.presentViewController(self.debugAlertController, animated: true, completion: { () -> Void in
            self.inDebugMenu = true
        })
    }

    // MARK: Private Methods

    private func presentViewController(viewControllerToDisplay: UIViewController) {
        guard let presentingViewController = self.rootViewController else { return }
        presentingViewController.presentViewController(viewControllerToDisplay, animated: true, completion: { () -> Void in
            self.inDebugMenu = false
        })
    }

    private func dismiss(viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true) { () -> Void in
            self.inDebugMenu = false
        }
    }

    private func tableViewAction(menu: YoshiTableViewMenu) -> UIAlertAction {
        return UIAlertAction(title: menu.debugMenuName, style: .Default) { (_) -> Void in
            let bundle = NSBundle(forClass: DebugConfigurationManager.self)
            let tableViewController = DebugTableViewController(nibName: DebugTableViewController.nibName(), bundle: bundle)
            tableViewController.modalPresentationStyle = .FullScreen
            tableViewController.setup(menu)
            tableViewController.delegate = self
            self.presentViewController(tableViewController)
        }
    }

    private func dateSelectorAction(menu: YoshiDateSelectorMenu) -> UIAlertAction {
        return UIAlertAction(title: menu.debugMenuName, style: .Default, handler: { (_) -> Void in
            let bundle = NSBundle(forClass: DebugConfigurationManager.self)
            let datePickerViewController = DebugDatePickerViewController(nibName: DebugDatePickerViewController.nibName(), bundle: bundle)
            datePickerViewController.setup(menu)
            datePickerViewController.delegate = self
            datePickerViewController.date = self.currentDate
            self.presentViewController(datePickerViewController)
        })
    }

    private func customMenuAction(menu: YoshiCustomMenu) -> UIAlertAction {
        menu.setup()
        return UIAlertAction(title: menu.debugMenuName, style: .Default) { (_) -> Void in
            menu.completion()
            self.inDebugMenu = false
        }
    }

}

// MARK: DebugDatePickerViewControllerDelegate

extension DebugConfigurationManager: DebugDatePickerViewControllerDelegate {

    func didUpdateDate(date: NSDate) {
        self.currentDate = date
    }

    func shouldDismissDatePickerView(viewController: UIViewController) {
        self.dismiss(viewController)
    }

}

// MARK: DebugTableViewControllerDelegate

extension DebugConfigurationManager: DebugTableViewControllerDelegate {

    func shouldDismissDebugTableView(viewController: UIViewController) {
        self.dismiss(viewController)
    }
    
}
