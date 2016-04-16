//
//  MenuItem.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import Yoshi

internal final class MenuItem: YoshiTableViewMenuItem {

    let name: String
    var selected: Bool

    init(name: String,
         selected: Bool = false) {
        self.name = name
        self.selected = selected
    }

}

struct TableViewMenu: YoshiTableViewMenu {

    var title: String
    var subtitle: String?
    var displayItems: [YoshiTableViewMenuItem]
    var didSelectDisplayItem: (displayItem: YoshiTableViewMenuItem) -> ()

}

struct DateSelector: YoshiDateSelectorMenu {

    var title: String
    var subtitle: String?
    var didUpdateDate: (dateSelected: NSDate) -> ()

}


struct TestMenuItem: YoshiMenu {
    let title = "Test"
    let subtitle: String? = nil

    func execute() -> YoshiActionResult {
        print ("Executed")
        return .Handled
    }
}
