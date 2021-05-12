//
//  Color.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 A color object
 */
struct Color {

    /// The red value.
    let red: UInt8

    /// The green value
    let green: UInt8

    /// The blue value.
    let blue: UInt8

    /// The alpha value.
    let alpha: Float

    /**
     Initializes a new color.

     - parameter red:   The red component.
     - parameter green: The green component.
     - parameter blue:  The blue component.
     - parameter alpha: The alpha channel. By default, this is 1.0.
     */
    init(_ red: UInt8, _ green: UInt8, _ blue: UInt8, alpha: Float = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    /**
     Generates a UIColor.

     - returns: The UIColor value.
     */
    func toUIColor() -> UIColor {
        let rFloat = CGFloat(red)
        let gFloat = CGFloat(green)
        let bFloat = CGFloat(blue)

        let maxValue = CGFloat(UInt8.max)
        return UIColor(red: (rFloat / maxValue),
                       green: (gFloat / maxValue),
                       blue: (bFloat / maxValue),
                       alpha: CGFloat(alpha))
    }

}
