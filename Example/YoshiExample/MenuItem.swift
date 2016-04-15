//
//  MenuItem.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import Yoshi

struct MenuItem: YoshiTableViewMenuItem {

    var name: String

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
