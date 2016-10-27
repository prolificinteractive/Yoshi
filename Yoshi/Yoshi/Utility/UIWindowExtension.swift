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

    override open func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        Yoshi.motionBegan(motion, withEvent: event)
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesBegan(touches, withEvent: event)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        Yoshi.touchesMoved(touches, withEvent: event)
    }

}
