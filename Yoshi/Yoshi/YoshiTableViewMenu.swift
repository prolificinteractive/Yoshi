//
//  YoshiTableViewMenu.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 A menu item for displaying a table view.
 */
public protocol YoshiTableViewMenu: YoshiMenu {

    /// The items to display in the table view.
    var displayItems: [YoshiTableViewMenuItem] { get }

    /// Function to be called when an item is selected.
    var didSelectDisplayItem: (_ displayItem: YoshiTableViewMenuItem) -> Void { get }

}

public extension YoshiTableViewMenu {

    /**
     Function to execute when the menu item is seleted.

     - returns: A result for handling the selected menu item.
     */
    func execute() -> YoshiActionResult {
        let bundle = Bundle(for: YoshiConfigurationManager.self)
        let tableViewController =
            DebugTableViewController(nibName: String(describing: DebugTableViewController.self), bundle: bundle)
        tableViewController.setup(self)

        return .presentViewController(tableViewController)
    }

}
