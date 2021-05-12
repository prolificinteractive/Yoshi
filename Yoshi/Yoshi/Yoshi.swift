//
//  Yoshi.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/// The Debug Menu interface.
public final class Yoshi {

    // MARK: - Setup

    /**
     Should be called in application didFinishLaunchingWithOptions

     - parameter menuItems: [YoshiGenericMenu] an array of items to be displayed in the Yoshi Debug Action Sheet.
     - parameter invocations: The invocation types.
     */
    public class func setupDebugMenu(_ menuItems: [YoshiGenericMenu], invocations: [YoshiInvocation] = [.all]) {
        YoshiConfigurationManager.sharedInstance.setupDebugMenuOptions(menuItems, invocations: invocations)
    }
    
    /**
     Allows client application to indicate it has restarted.
     Clears inertnal state.
     */
    public static func restart() {
        YoshiConfigurationManager.sharedInstance.restart()
    }

    // MARK: - Invocation Functions

    /**
     Should be called when a motion event is received. This will handle showing the hidden debug menu.

     - parameter motion: (UIEventSubtype) the motion captured by the original motionBegan call
     - parameter event:  (UIEvent) the event captured by the original motionBegan call
     */
    public class func motionBegan(_ motion: UIEvent.EventSubtype, withEvent event: UIEvent?) {
        guard motion == .motionShake
            && YoshiConfigurationManager.sharedInstance.shouldShow(.shakeMotionGesture) else {
            return
        }

        show()
    }

    /**
     Should be called when touch events are received. This will handle showing the hidden debug menu.

     - parameter touches:                 Set<UITouch> the touches received by the original touchesBegan
     - parameter event:                   (UIEvent) the event captured by the original touchesBegan call
     - parameter minimumTouchRequirement: (Int) the minimum number of touches required to show the debug menu.
     */
    public class func touchesBegan(_ touches: Set<UITouch>, withEvent event: UIEvent?,
                                   minimumTouchRequirement: Int = 3) {
        guard (event?.allTouches?.count)! >= minimumTouchRequirement
            && YoshiConfigurationManager.sharedInstance.shouldShow(.multiTouch) else {
            return
        }

        show()
    }

    /**
     Should be called when touches moved. This will handle showing the hidden debug menu.

     - parameter touches:                 Set<UITouch> the touches received by the original touchesMoved
     - parameter event:                   (UIEvent) the event captured by the original touchesMoved call
     - parameter minimumForcePercent:     (Int) the minimum force percent required to show the debug menu.
     */
    public class func touchesMoved(_ touches: Set<UITouch>, withEvent event: UIEvent?,
                                   minimumForcePercent: Float = 60) {
        guard #available(iOS 9.0, *) else {
            return
        }

        guard YoshiConfigurationManager.sharedInstance.shouldShow(.multiTouch) else {
            return
        }

        let eventTouches = event?.allTouches?.filter({ (touch) -> Bool in
            // Guarding against touch.maximumPossibleForce > 0
            // because this value is 0 on non-3D touch capable devices
            guard touch.maximumPossibleForce > 0 else {
                return false
            }

            let percent = CGFloat(minimumForcePercent)
            return touch.force >= touch.maximumPossibleForce * (percent / 100)
        })

        guard let touches = eventTouches, touches.count > 0 else {
            return
        }

        show()
    }

    /**
     Should be called directly only if you want to manually invoke Yoshi
     */
    public class func show() {
        YoshiConfigurationManager.sharedInstance.show()
    }

    /// Return a navigation controller presenting the debug view controller.
    ///
    /// - Returns: Debug navigation controller
    public class func debugNavigationController() -> UINavigationController {
        return YoshiConfigurationManager.sharedInstance.debugNavigationController()
    }

    /**
     Dismisses the debug menu, if it is opened. The input block is executed after it has dismissed.

     - parameter completion: The block to execute upon completion of dismissal.
     */
    public class func dismiss(_ completion: (() -> Void)? = nil) {
        YoshiConfigurationManager.sharedInstance.dismiss(completion)
    }

}
