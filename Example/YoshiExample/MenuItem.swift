//
//  MenuItem.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import Yoshi

/**
 *  A custom menu item to be displayed in a YoshiTableViewMenu.
 */
internal final class MenuItem: YoshiTableViewMenuItem {

    let name: String
    var selected: Bool

    init(name: String,
         selected: Bool = false) {
        self.name = name
        self.selected = selected
    }

}

/**
 *  A menu item to be displayed in Yoshi.
 */
struct TableViewMenu: YoshiTableViewMenu {

    var title: String
    var subtitle: String?
    var displayItems: [YoshiTableViewMenuItem]
    var didSelectDisplayItem: (displayItem: YoshiTableViewMenuItem) -> ()

}

/**
 *  A date selector menu item to be displayed in Yoshi.
 */
struct DateSelector: YoshiDateSelectorMenu {

    var title: String
    var subtitle: String?
    var didUpdateDate: (dateSelected: NSDate) -> ()

}

/**
 *  A custom menu item to be displayed in Yoshi.
 */
struct TestMenuItem: YoshiMenu {
    let title = "Custom Action"
    let subtitle: String? = "Runs a custom action"

    func execute() -> YoshiActionResult {
        print ("Executed custom functionality.")
        return .Handled
    }
}
