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
internal final class DateSelector: YoshiDateSelectorMenu {

    var title: String
    var subtitle: String?
    var selectedDate: NSDate
    var didUpdateDate: (dateSelected: NSDate) -> ()

    init(title: String,
         subtitle: String? = nil,
         selectedDate: NSDate = NSDate(),
         didUpdateDate: (NSDate) -> ()) {
        self.title = title
        self.subtitle = subtitle
        self.selectedDate = selectedDate
        self.didUpdateDate = didUpdateDate
    }
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
