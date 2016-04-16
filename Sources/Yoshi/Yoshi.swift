//
//  Yoshi.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

/// The Debug Menu interface.
public final class Yoshi {

    // MARK: Setup

    /**
    Should be called in application didFinishLaunchingWithOptions

    - parameter menuItems: [YoshiMenu] an array of items to be displayed in the Yoshi Debug Action Sheet
    */
    public class func setupDebugMenu(menuItems: [YoshiMenu]) {
        YoshiConfigurationManager.sharedInstance.setupDebugMenuOptions(menuItems)
    }

    // MARK: Invocation Functions

    /**
    Should be called when a motion event is received. This will handle showing the hidden debug menu.

    - parameter motion: (UIEventSubtype) the motion captured by the original motionBegan call
    - parameter event:  (UIEvent) the event captured by the original motionBegan call
    */
    public class func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        guard motion == .MotionShake else {
            return
        }

        showDebugActionSheet()
    }

    /**
     Should be called when touch events are received. This will handle showing the hidden debug menu.

     - parameter touches:                 Set<UITouch> the touches received by the original touchesBegan
     - parameter event:                   (UIEvent) the event captured by the original touchesBegan call
     - parameter minimumTouchRequirement: (Int) the minimum number of touches required to show the debug menu.
     */
    public class func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?, minimumTouchRequirement: Int = 3) {
        guard event?.allTouches()?.count >= minimumTouchRequirement else {
            return
        }

        showDebugActionSheet()
    }

    /**
     Should be called when touches moved. This will handle showing the hidden debug menu.

     - parameter touches:                 Set<UITouch> the touches received by the original touchesMoved
     - parameter event:                   (UIEvent) the event captured by the original touchesMoved call
     - parameter minimumForcePercent:     (Int) the minimum force percent required to show the debug menu.
     */
    public class func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?, minimumForcePercent: Float = 60) {
        guard #available(iOS 9.0, *) else {
            return
        }

        let eventTouches = event?.allTouches()?.filter({ (touch) -> Bool in
            // Guarding against touch.maximumPossibleForce > 0
            // because this value is 0 on non-3D touch capable devices
            guard touch.maximumPossibleForce > 0 else {
                return false
            }

            let percent = CGFloat(minimumForcePercent)
            return touch.force >= touch.maximumPossibleForce * (percent / 100)
        })

        guard let touches = eventTouches where touches.count > 0 else {
            return
        }

        showDebugActionSheet()
    }

    /**
     Should be called directly only if you want to manually invoke Yoshi
     */
    public class func showDebugActionSheet() {
        YoshiConfigurationManager.sharedInstance.showDebugActionSheet()
    }

}
