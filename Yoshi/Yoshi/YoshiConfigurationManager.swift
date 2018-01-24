//
//  DebugConfigurationManager.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/// The configuration manager for the debug menu.
internal final class YoshiConfigurationManager {

    /// The default instance.
    static let sharedInstance = YoshiConfigurationManager()

    private var yoshiMenuItems = [YoshiGenericMenu]()
    private var invocations: [YoshiInvocation]?
    private var presentingWindow: UIWindow?
    private weak var debugViewController: DebugViewController?

    /**
     Sets the debug options to use for presenting the debug menu.

     - parameter menuItems: The menu items for presentation.
     - parameter invocations: The invocation types.
     */
    func setupDebugMenuOptions(_ menuItems: [YoshiGenericMenu], invocations: [YoshiInvocation]) {
        yoshiMenuItems = menuItems
        self.invocations = invocations
    }
    
    /**
     Allows client application to indicate it has restarted.
     Clears inertnal state.
     */
    func restart() {
        presentingWindow = nil
        debugViewController = nil
        
        guard let invocations = invocations else {
            return
        }
        
        setupDebugMenuOptions(yoshiMenuItems, invocations: invocations)
    }

    /// Helper function to indicate if the given invocation should show Yoshi.
    ///
    /// - parameter invocation: Invocation method called.
    ///
    /// - returns: `true` if Yoshi should appear. `false` if not.
    func shouldShow(_ invocation: YoshiInvocation) -> Bool {
        guard let invocations = invocations else {
            return false
        }

        if  invocations.contains(.all) {
            return true
        }

        return invocations.contains(invocation)
    }

    /**
     Invokes the display of the debug menu.
     */
    func show() {
        guard presentingWindow == nil else {
            return
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindowLevelNormal

        // Use a dummy view controller with clear background.
        // This way, we can make the actual view controller we want to present a form sheet on the iPad.
        let rootViewController = UIViewController()
        rootViewController.view.backgroundColor = UIColor.clear

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        presentingWindow = window

        // iOS doesn't like when modals are presented right away after a window's been made key and visible.
        // We need to delay presenting the debug controller a bit to suppress the warning.
        DispatchQueue.main.asyncAfter(deadline:
                DispatchTime.now() + Double(Int64(0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.presentDebugViewController()
        }
    }

    /// Return a navigation controller presenting the debug view controller.
    ///
    /// - Returns: Debug navigation controller
    func debugNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()

        let debugViewController = DebugViewController(options: yoshiMenuItems, isRootYoshiMenu: true, completion: { _ in
            navigationController.dismiss(animated: true)
        })
        self.debugViewController = debugViewController

        navigationController.setViewControllers([debugViewController], animated: false)

        return navigationController
    }

    /**
     Dismisses the debug view controller, if possible.

     - parameter action: The action to take upon completion.
     */
    func dismiss(_ action: VoidCompletionBlock? = nil) {
        if let completionHandler = debugViewController?.completionHandler {
            completionHandler(action)
        }
        presentingWindow = nil
    }

    private func presentDebugViewController() {
        if let rootViewController = presentingWindow?.rootViewController {
            let navigationController = UINavigationController()
            let debugViewController = DebugViewController(options: yoshiMenuItems,
                                                          isRootYoshiMenu: true,
                                                          completion: { [weak self] completionBlock in
                                                            rootViewController
                                                                .dismiss(animated: true,
                                                                    completion: { () -> Void in
                                                                        self?.presentingWindow = nil
                                                                        completionBlock?()
                                                                })
                })

            navigationController.modalPresentationStyle = .formSheet
            navigationController.setViewControllers([debugViewController], animated: false)

            rootViewController.present(navigationController, animated: true, completion: nil)
            self.debugViewController = debugViewController
        }
    }

}
