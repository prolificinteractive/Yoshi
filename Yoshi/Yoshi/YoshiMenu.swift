//
//  Yoshi.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/**
 Defines an object as a debug menu option
 */
public protocol YoshiMenu {

    /// The display name for the menu option.
    var title: String { get }

    /// The value for the option. This will be displayed as the subtitle in the menu.
    var subtitle: String? { get }

    /**
     Function to execute when the menu item is seleted.

     - returns: A result for handling the selected menu item.
     */
    func execute() -> YoshiActionResult

}
