//
//  DebugMenu.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

public class DebugMenu: NSObject {

    /**
     Must be called in application didFinishLaunchingWithOptions

     - parameter menuItems: [YoshiMenu] an array of items to be displayed in the Yoshi Debug Action Sheet
     */
    public class func setupDebugMenu(menuItems: [YoshiMenu]) {
        DebugConfigurationManager.sharedInstance.setupDebugMenuOptions(menuItems)
    }

    /**
    Must be called when a motion action is recieved. This will handle showing the hidden debug menu.

    - parameter motion: (UIEventSubtype) the motion captured by the original motionBegan call
    - parameter event:  (UIEvent) the event captured by the original motionBegan call
    */
    public class func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (motion == UIEventSubtype.MotionShake
            && !DebugConfigurationManager.sharedInstance.inDebugMenu)
        {
            let window = UIApplication.sharedApplication().windows.last
            guard let rootViewController = window?.rootViewController else {
                return
            }
            
            DebugConfigurationManager.sharedInstance.showDebugActionSheetFromViewController(rootViewController)
        }
    }

    
}
