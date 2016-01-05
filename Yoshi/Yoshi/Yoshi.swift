//
//  Yoshi.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

public protocol YoshiMenu {
    var debugMenuName: String { get }
}

public protocol YoshiTableViewMenuItem {
    func displayText() -> String
}

public protocol YoshiTableViewMenu: YoshiMenu {
    var displayItems: [YoshiTableViewMenuItem] { get }
    var didSelectDisplayItem: (displayItem: YoshiTableViewMenuItem) -> () { get }
}

public protocol YoshiDateSelectorMenu: YoshiMenu {
    var didUpdateDate: (dateSelected: NSDate) -> () { get }
}

public protocol YoshiCustomMenu: YoshiMenu {
    var setup: () -> () { get }
    var completion: () -> () { get }
}