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
    var didSelectDisplayItem: (displayItem: YoshiTableViewMenuItem) -> () { get }

}

public extension YoshiTableViewMenu {

    func execute() -> YoshiActionResult {
        let bundle = NSBundle(forClass: YoshiConfigurationManager.self)
        let tableViewController =
            DebugTableViewController(nibName: String(DebugTableViewController), bundle: bundle)
        tableViewController.setup(self)

        return .PresentViewController(tableViewController)
    }

}
