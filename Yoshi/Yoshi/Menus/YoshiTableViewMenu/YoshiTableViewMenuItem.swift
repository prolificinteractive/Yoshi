//
//  YoshiTableViewMenuItem.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 A table view menu item.
 */
public protocol YoshiTableViewMenuItem: class {

    /// The display text for the table view menu item.
    var name: String { get }

    /// The display sub text for the table view menu item.
    var subtitle: String? { get }

    // Indicates whether or not this item is selectable.
    var selected: Bool { get set }

}
