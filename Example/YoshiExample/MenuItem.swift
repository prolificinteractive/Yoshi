//
//  MenuItem.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit
import Yoshi

struct MenuItem: YoshiTableViewMenuItem {
    var name: String

    func displayText() -> String {
        return name
    }
}

struct TableViewMenu: YoshiTableViewMenu {
    var debugMenuName: String
    var displayItems: [YoshiTableViewMenuItem]
    var didSelectDisplayItem: (displayItem: YoshiTableViewMenuItem) -> ()
}

struct CustomMenu: YoshiCustomMenu {
    var debugMenuName: String
    var setup: () -> ()
    var completion: () -> ()
}

struct DateSelector: YoshiDateSelectorMenu {
    var debugMenuName: String
    var didUpdateDate: (dateSelected: NSDate) -> ()
}
