//
//  UIWindow+DebugMotionEvents.swift
//  Pods
//
//  Created by Christopher Jones on 2/6/16.
//
//

extension UIWindow {
    struct Static {
        static var token: dispatch_once_t = 0
    }

    public override class func initialize() {
        guard self === UIWindow.self else {
            return
        }

        dispatch_once(&Static.token) {
            UIWindow.setupSwizzle(
                Selector("motionBegan:withEvent:"),
                swizzledSelector: Selector("debugMotionBegan:withEvent:"))
            UIWindow.setupSwizzle(
                Selector("touchesBegan:withEvent:"),
                swizzledSelector: Selector("debugTouchesBegan:withEvent:"))
            UIWindow.setupSwizzle(
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

        if didAddMethod {
            class_replaceMethod(
                self,
                swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }

    }

    // MARK: - Method Swizzling
    func debugMotionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        guard DebugConfigurationManager.sharedInstance.yoshiInvocationEvent == .ShakeMotion
            && !DebugConfigurationManager.sharedInstance.inDebugMenu else {
                return
        }

        DebugConfigurationManager.sharedInstance.showDebugActionSheet()
    }

    func debugTouchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(event?.allTouches()?.count)
        switch DebugConfigurationManager.sharedInstance.yoshiInvocationEvent {
        case .MultiTouch:
            showDebugMenuForMultiTouch(event)
        case .ForceTouch:
            showDebugMenuForForceTouch(event)
        default:
            break
        }
    }

    func debugTouchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        showDebugMenuForForceTouch(event)
    }

    private func showDebugMenuForMultiTouch(event: UIEvent?) {
        guard DebugConfigurationManager.sharedInstance.yoshiInvocationEvent == .MultiTouch
            && DebugConfigurationManager.sharedInstance.didInvokeStart
            && event?.allTouches()?.count >= DebugConfigurationManager.sharedInstance.touchInvocationminimumTouchRequirement
            && !DebugConfigurationManager.sharedInstance.inDebugMenu else { return }
        DebugConfigurationManager.sharedInstance.showDebugActionSheet()
    }

    private func showDebugMenuForForceTouch(event: UIEvent?) {
        if #available(iOS 9, *) {
            guard DebugConfigurationManager.sharedInstance.yoshiInvocationEvent == .ForceTouch
                && DebugConfigurationManager.sharedInstance.didInvokeStart
                && event?.allTouches()?.filter({ touch in
                    print("force = \(touch.force)")
                    return touch.force == touch.maximumPossibleForce
                }).count > 0
                && !DebugConfigurationManager.sharedInstance.inDebugMenu else {
                    return
            }

            DebugConfigurationManager.sharedInstance.showDebugActionSheet()
        }
    }
    
}
