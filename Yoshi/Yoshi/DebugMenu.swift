//
//  DebugMenu.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

public class DebugMenu {

    /**
     Should be called in application didFinishLaunchingWithOptions

     - parameter menuItems: [YoshiMenu] an array of items to be displayed in the Yoshi Debug Action Sheet
     */
    public class func setupDebugMenu(menuItems: [YoshiMenu]) {
        DebugConfigurationManager.sharedInstance.setupDebugMenuOptions(menuItems)
    }

    /**
     Should be called when a motion action is received. This will handle showing the hidden debug menu.

     - parameter motion: (UIEventSubtype) the motion captured by the original motionBegan call
     - parameter event:  (UIEvent) the event captured by the original motionBegan call
     */
    public class func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        guard motion == .MotionShake
            && !DebugConfigurationManager.sharedInstance.inDebugMenu else { return }
        DebugMenu.showDebugActionSheet()
    }

    /**
     Should be called when touches are received. This will handle showing the hidden debug menu.

     - parameter touches:                 Set<UITouch> the touches received by the origininal touchesBegan
     - parameter event:                   (UIEvent) the event captured by the original motionBegan call
     - parameter minimumTouchRequirement: (Int) the minimum number of touches required to show the debug menu.
     */
    public class func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?, minimumTouchRequirement: Int = 3) {
        guard event?.allTouches()?.count >= minimumTouchRequirement
            && !DebugConfigurationManager.sharedInstance.inDebugMenu else { return }
        DebugMenu.showDebugActionSheet()
    }

    private class func showDebugActionSheet() {
        let window = UIApplication.sharedApplication().windows.last
        guard let rootViewController = window?.rootViewController else {
            return
        }

        DebugConfigurationManager.sharedInstance.showDebugActionSheetFromViewController(rootViewController)
    }

}
