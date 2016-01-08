//
//  DebugMenu.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

public enum InvocationEvent {
    case ShakeMotion
}

public class DebugMenu {

    /**
     Should be called in application didFinishLaunchingWithOptions

     - parameter menuItems: [YoshiMenu] an array of items to be displayed in the Yoshi Debug Action Sheet
     */
    public class func startWithInvokeEvent(invocationEvent: InvocationEvent = .ShakeMotion, menuItems: [YoshiMenu]) {
        DebugConfigurationManager.sharedInstance.startWithInvokeEvent(invocationEvent, menuItems: menuItems)
    }

}
