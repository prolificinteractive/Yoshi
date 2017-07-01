//
//  TableViewMenu.swift
//  YoshiExample
//
//  Created by Kanglei Fang on 7/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Yoshi

/// A menu item to be displayed in Yoshi.
/// Note that YoshiTableViewMenu has been deprecated, consider using YoshiGenericMenu instead.
internal struct TableViewMenu: YoshiTableViewMenu {
    
    var title: String
    var subtitle: String?
    var displayItems: [YoshiTableViewMenuItem]
    var didSelectDisplayItem: (_ displayItem: YoshiTableViewMenuItem) -> Void
    
}

/// A submenu that dynamically changes its subtitle.
internal struct Submenu: YoshiSubmenu {
    
    let title: String
    var options: [YoshiGenericMenu]
    
    /// Block returns menu's subtitle on-demand.
    var dynamicSubtitle: () -> String?
    
    var subtitle: String? {
        return dynamicSubtitle()
    }
}
