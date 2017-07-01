//
//  TableViewMenuItem.swift
//  YoshiExample
//
//  Created by Kanglei Fang on 7/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Yoshi

/// A custom menu item to be displayed in a YoshiTableViewMenu.
/// Note that YoshiTableViewMenuItem has been deprecated, consider using YoshiSubmenu like examples below.
internal final class TableViewMenuItem: YoshiTableViewMenuItem {
    
    let name: String
    let subtitle: String?
    var selected: Bool
    
    init(name: String,
         subtitle: String? = nil,
         selected: Bool = false) {
        self.name = name
        self.subtitle = subtitle
        self.selected = selected
    }
    
}

/// A custom menu item to be displayed in a YoshiSubmenu.
internal final class SubviewMenuItem: YoshiMenu {
    
    let title: String
    let subtitle: String?
    
    /// If the item is selected.
    var selected: Bool
    
    /// Action executed when selected.
    let action: (SubviewMenuItem) -> Void
    
    init(title: String,
         subtitle: String? = nil,
         selected: Bool = false,
         action: @escaping (SubviewMenuItem) -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.selected = selected
        self.action = action
    }
    
    /// Display a normal Yoshi cell with a checkmark reflecting selection state.
    var cellSource: YoshiReusableCellDataSource {
        return YoshiMenuCellDataSource(title: title, subtitle: subtitle, accessoryType: selected ? .checkmark : .none)
    }
    
    func execute() -> YoshiActionResult {
        action(self)
        return .pop
    }
    
}
