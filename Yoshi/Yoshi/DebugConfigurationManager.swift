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
    var invocationEvent: InvocationEvent = .ShakeMotion
    let touchInvocationminimumTouchRequirement = 3
    let debugAlertController =
    UIAlertController(title: AppBundleUtility.appVersionText(), message: nil, preferredStyle: .ActionSheet)
    var yoshiMenuItems = [YoshiMenu]()
    var rootViewController: UIViewController?

    func startWithInvokeEvent(invocationEvent: InvocationEvent, menuItems: [YoshiMenu]) {
        self.invocationEvent = invocationEvent

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

    // MARK: Private Methods

    private func showDebugActionSheet() {
        let window = UIApplication.sharedApplication().windows.last
        guard let rootViewController = window?.rootViewController else {
            return
        }

        self.rootViewController = rootViewController
        rootViewController.presentViewController(self.debugAlertController, animated: true, completion: { () -> Void in
            self.inDebugMenu = true
        })
    }

    private func presentViewController(viewControllerToDisplay: UIViewController) {
        guard let presentingViewController = self.rootViewController else { return }
        presentingViewController
            .presentViewController(viewControllerToDisplay, animated: true, completion: { () -> Void in
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
            let tableViewController =
            DebugTableViewController(nibName: DebugTableViewController.nibName(), bundle: bundle)
            tableViewController.modalPresentationStyle = .FullScreen
            tableViewController.setup(menu)
            tableViewController.delegate = self
            self.presentViewController(tableViewController)
        }
    }

    private func dateSelectorAction(menu: YoshiDateSelectorMenu) -> UIAlertAction {
        return UIAlertAction(title: menu.debugMenuName, style: .Default, handler: { (_) -> Void in
            let bundle = NSBundle(forClass: DebugConfigurationManager.self)
            let datePickerViewController =
            DebugDatePickerViewController(nibName: DebugDatePickerViewController.nibName(), bundle: bundle)
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

extension UIResponder {
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }

        // make sure this isn't a subclass
        if self !== UIResponder.self {
            return
        }

        dispatch_once(&Static.token) {
            UIResponder.setupSwizzle(
                Selector("motionBegan:withEvent:"),
                swizzledSelector: Selector("debugMotionBegan:withEvent:"))
            UIResponder.setupSwizzle(
                Selector("touchesBegan:withEvent:"),
                swizzledSelector: Selector("debugTouchesBegan:withEvent:"))
            UIResponder.setupSwizzle(
                Selector("touchesMoved:withEvent:"),
                swizzledSelector: Selector("debugTouchesMoved:withEvent:"))
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

        guard didAddMethod else { method_exchangeImplementations(originalMethod, swizzledMethod); return }

        class_replaceMethod(
            self,
            swizzledSelector,
            method_getImplementation(originalMethod),
            method_getTypeEncoding(originalMethod)
        )
    }

    // MARK: - Method Swizzling
    func debugMotionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        guard DebugConfigurationManager.sharedInstance.invocationEvent == InvocationEvent.ShakeMotion
            && !DebugConfigurationManager.sharedInstance.inDebugMenu else { return }
        DebugConfigurationManager.sharedInstance.showDebugActionSheet()
        debugMotionBegan(motion, withEvent: event)
    }

    func debugTouchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        switch DebugConfigurationManager.sharedInstance.invocationEvent {
        case .MultiTouch:
            showDebugMenuForMultiTouch(touches)
        case .ForceTouch:
            showDebugMenuForForceTouch(touches)
        default:
            break
        }

        debugTouchesBegan(touches, withEvent: event)
    }

    func debugTouchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        showDebugMenuForForceTouch(touches)
        debugTouchesMoved(touches, withEvent: event)
    }

    private func showDebugMenuForMultiTouch(touches: Set<UITouch>) {
        guard DebugConfigurationManager.sharedInstance.invocationEvent == InvocationEvent.MultiTouch
            && touches.count >= DebugConfigurationManager.sharedInstance.touchInvocationminimumTouchRequirement
            && !DebugConfigurationManager.sharedInstance.inDebugMenu else { return }
        DebugConfigurationManager.sharedInstance.showDebugActionSheet()
    }

    private func showDebugMenuForForceTouch(touches: Set<UITouch>) {
        guard DebugConfigurationManager.sharedInstance.invocationEvent == InvocationEvent.ForceTouch
            && touches.filter({ (touch) -> Bool in
                guard #available(iOS 9.0, *) else { return false }
                print("force = \(touch.force)")
                return touch.force >= touch.maximumPossibleForce / 2
            }).count > 0
            && !DebugConfigurationManager.sharedInstance.inDebugMenu else { return }
        DebugConfigurationManager.sharedInstance.showDebugActionSheet()
    }
    
}
