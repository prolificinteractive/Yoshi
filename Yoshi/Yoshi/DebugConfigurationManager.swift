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

    var yoshiInvocationEvent: InvocationEvent = .ShakeMotion
    var touchInvocationminimumTouchRequirement = 3
    var inDebugMenu: Bool = false
    var didInvokeStart: Bool = false

    private var currentDate = NSDate()
    private lazy var debugAlertController: UIAlertController = {
        var preferredStyle: UIAlertControllerStyle

        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            preferredStyle = .ActionSheet
        default:
            preferredStyle = .Alert
        }
        return UIAlertController(title: AppBundleUtility.appVersionText(), message: nil, preferredStyle: preferredStyle)
    }()

    private var yoshiMenuItems = [YoshiMenu]()

    func startWithInvokeEvent(invocationEvent: InvocationEvent, menuItems: [YoshiMenu]) {
        yoshiInvocationEvent = invocationEvent
        yoshiMenuItems = menuItems
        didInvokeStart = true

        for menuItem in yoshiMenuItems {
            switch menuItem {
            case let menuType as YoshiTableViewMenu:
                let tableViewAction = self.tableViewAction(menuType)
                debugAlertController.addAction(tableViewAction)
            case let menuType as YoshiDateSelectorMenu:
                let datePickerAction = self.datePickerAction(menuType)
                debugAlertController.addAction(datePickerAction)
            case let menuType as YoshiCustomMenu:
                let customMenuAction = self.customMenuAction(menuType)
                debugAlertController.addAction(customMenuAction)
            default:
                continue
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (alertAction) -> Void in
            self.inDebugMenu = false
        }
        debugAlertController.addAction(cancelAction)
    }

    func showDebugActionSheet() {
        guard !inDebugMenu else {
            return
        }
        presentViewController(debugAlertController) { () -> Void in
            self.inDebugMenu = true
        }
    }

    // MARK: Private Methods

    private func presentViewController(viewControllerToDisplay: UIViewController, presentedCompletion: () -> Void) {
        let window = UIApplication.sharedApplication().keyWindow
        guard let rootViewController = window?.rootViewController else {
            return
        }
        rootViewController
            .presentViewController(viewControllerToDisplay, animated: true, completion: presentedCompletion)
    }

    private func dismiss(viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true) { () -> Void in
            self.inDebugMenu = false
        }
    }

    private func tableViewAction(menu: YoshiTableViewMenu) -> UIAlertAction {
        return UIAlertAction(title: menu.debugMenuName, style: .Default) { (_) -> Void in
            let bundle = NSBundle(forClass: DebugConfigurationManager.self)
            let tableViewController =
                DebugTableViewController(nibName: String(DebugTableViewController), bundle: bundle)
            tableViewController.modalPresentationStyle = .FormSheet
            tableViewController.setup(menu)
            tableViewController.tableViewControllerDelegate = self
            self.presentViewController(tableViewController) {
                self.inDebugMenu = true
            }
        }
    }

    private func datePickerAction(menu: YoshiDateSelectorMenu) -> UIAlertAction {
        return UIAlertAction(title: menu.debugMenuName, style: .Default, handler: { (_) -> Void in
            let bundle = NSBundle(forClass: DebugConfigurationManager.self)
            let datePickerViewController =
                DebugDatePickerViewController(nibName: String(DebugDatePickerViewController), bundle: bundle)
            datePickerViewController.modalPresentationStyle = .FormSheet
            datePickerViewController.setup(menu)
            datePickerViewController.datePickerViewControllerDelegate = self
            datePickerViewController.date = self.currentDate
            self.presentViewController(datePickerViewController) {
                self.inDebugMenu = true
            }
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
        currentDate = date
    }

    func shouldDismissDatePickerView(viewController: UIViewController) {
        dismiss(viewController)
    }

}

// MARK: DebugTableViewControllerDelegate

extension DebugConfigurationManager: DebugTableViewControllerDelegate {

    func shouldDismissDebugTableView(viewController: UIViewController) {
        dismiss(viewController)
    }
    
}
