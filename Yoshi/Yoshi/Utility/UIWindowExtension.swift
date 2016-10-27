//
//  UIWindowExtension.swift
//  Yoshi
//
//  Created by Quentin Ribierre on 10/24/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit


// MARK: - UIWindow Extension.
public extension UIWindow {

    override public func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        Yoshi.motionBegan(motion, withEvent: event)
    }

    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Yoshi.touchesBegan(touches, withEvent: event)
    }

    override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Yoshi.touchesMoved(touches, withEvent: event)
    }

}
