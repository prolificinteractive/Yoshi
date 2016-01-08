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
    var didInvokeStart: Bool = false
    var yoshiInvocationEvent: InvocationEvent = .ShakeMotion
    let debugAlertController =
    UIAlertController(title: AppBundleUtility.appVersionText(), message: nil, preferredStyle: .ActionSheet)
    var yoshiMenuItems = [YoshiMenu]()
    var yoshiRootViewController: UIViewController?

    func startWithInvokeEvent(invocationEvent: InvocationEvent, menuItems: [YoshiMenu]) {
        yoshiInvocationEvent = invocationEvent
        yoshiMenuItems = menuItems
        didInvokeStart = true

        for menu in yoshiMenuItems {
            switch menu {
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
        let window = UIApplication.sharedApplication().windows.last
        guard let rootViewController = window?.rootViewController else {
            return
        }

        yoshiRootViewController = rootViewController
        rootViewController.presentViewController(debugAlertController, animated: true, completion: { () -> Void in
            self.inDebugMenu = false
        })
    }

    // MARK: Private Methods

    private func presentViewController(viewControllerToDisplay: UIViewController) {
        guard let presentingViewController = yoshiRootViewController else {
            return
        }
        presentingViewController
            .presentViewController(viewControllerToDisplay, animated: true, completion: { () -> Void in
            self.inDebugMenu = true
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
            let tableViewController =
            DebugTableViewController(nibName: DebugTableViewController.nibName(), bundle: bundle)
            tableViewController.modalPresentationStyle = .FullScreen
            tableViewController.setup(menu)
            tableViewController.tableViewControllerDelegate = self
            self.presentViewController(tableViewController)
        }
    }

    private func datePickerAction(menu: YoshiDateSelectorMenu) -> UIAlertAction {
        return UIAlertAction(title: menu.debugMenuName, style: .Default, handler: { (_) -> Void in
            let bundle = NSBundle(forClass: DebugConfigurationManager.self)
            let datePickerViewController =
            DebugDatePickerViewController(nibName: DebugDatePickerViewController.nibName(), bundle: bundle)
            datePickerViewController.setup(menu)
            datePickerViewController.datePickerViewControllerDelegate = self
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

private struct Static {
    static var token: dispatch_once_t = 0
}

extension UIResponder {

    public override class func initialize() {

        // make sure this isn't a subclass
        if self !== UIResponder.self {
            return
        }

        guard DebugConfigurationManager.sharedInstance.yoshiInvocationEvent == .ShakeMotion else {
            return
        }

        dispatch_once(&Static.token) {
            UIResponder.setupSwizzle(
                Selector("motionBegan:withEvent:"),
                swizzledSelector: Selector("debugMotionBegan:withEvent:"))
        }
    }

    private class func setupSwizzle(originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

        let didAddMethod = class_addMethod(
            self,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )

        guard didAddMethod else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
            return
        }

        class_replaceMethod(
            self,
            swizzledSelector,
            method_getImplementation(originalMethod),
            method_getTypeEncoding(originalMethod)
        )
    }

    // MARK: - Method Swizzling
    func debugMotionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        guard !DebugConfigurationManager.sharedInstance.inDebugMenu
        && DebugConfigurationManager.sharedInstance.didInvokeStart else {
            return
        }

        DebugConfigurationManager.sharedInstance.showDebugActionSheet()
        defer { debugMotionBegan(motion, withEvent: event) }
    }
}
