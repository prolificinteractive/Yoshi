//
//  YoshiGenericMenu.swift
//  Yoshi
//
//  Created by Kanglei Fang on 2/22/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/**
 Defines an object as a debug menu option
 */
public protocol YoshiGenericMenu {

    /// Reuse identifier for the cell.
    var cellSource: YoshiReusableCellDataSource { get }

    /**
     Function to execute when the menu item is seleted.

     - returns: A result for handling the selected menu item.
     */
    func execute() -> YoshiActionResult
}
