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
@available(*, deprecated, message: " Consider using YoshiSingleSelectionMenu instead")
public protocol YoshiTableViewMenuItem: class, YoshiGenericMenu {

    /// The display text for the table view menu item.
    var name: String { get }

    /// The display sub text for the table view menu item.
    var subtitle: String? { get }

    // Indicates whether or not this item is selectable.
    var selected: Bool { get set }

}

public extension YoshiTableViewMenuItem {

    /// The display sub text for the table view menu item.
    var subtitle: String? {
        return nil
    }

    var cellSource: YoshiReusableCellDataSource {
        return YoshiMenuCellDataSource(title: name, subtitle: subtitle, accessoryType: selected ? .checkmark : .none)
    }

    func execute() -> YoshiActionResult {
        return .pop
    }

}
