//
//  UIWindowExtension.swift
//  Yoshi
//
//  Created by Quentin Ribierre on 10/24/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

// MARK: - UIWindow Extension.
extension UIWindow {

    /// Function returning the amount of touch required to show Yoshi from a mulitple touch.
    /// Override this function to update the value.
    ///
    /// - Returns: count of touch required to show Yoshi.
    public func yoshiTouchesBeganMinimumTouchRequirement() -> Int {
        return 3
    }

    /// Function returning the amount of force required to show Yoshi from a force touch.
    /// Override this function to update the value.
    ///
    /// - Returns: value of force required to show Yoshi.
    public func yoshiTouchesMovedMinimumForcePercent() -> Float {
        return 60
    }

    override open func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        Yoshi.motionBegan(motion, withEvent: event)
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesBegan(touches,
                           withEvent: event,
                           minimumTouchRequirement: yoshiTouchesBeganMinimumTouchRequirement())
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesMoved(touches, withEvent: event, minimumForcePercent: yoshiTouchesMovedMinimumForcePercent())
    }

}
