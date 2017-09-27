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

@available(*, deprecated, message: " Consider using YoshiSingleSelectionMenu instead.")
public protocol YoshiTableViewMenu: YoshiSubmenu {

    /// The items to display in the table view.
    var displayItems: [YoshiTableViewMenuItem] { get }

    /// Function to be called when an item is selected.
    var didSelectDisplayItem: (_ displayItem: YoshiTableViewMenuItem) -> Void { get }

}

public extension YoshiTableViewMenu {

    var cellSource: YoshiReusableCellDataSource {
        let selectedDisplayItem = displayItems.filter { $0.selected == true }.first
        let subtitle = selectedDisplayItem?.name
        return YoshiMenuCellDataSource(title: title, subtitle: subtitle, accessoryType: .disclosureIndicator)
    }

    var options: [YoshiGenericMenu] {
        let selectedAction: (_ displayItem: YoshiTableViewMenuItem) -> Void = { selectedItem in
            self.displayItems.forEach { $0.selected = false }
            selectedItem.selected = true
            self.didSelectDisplayItem(selectedItem)
        }
        return displayItems.map { YoshiTableViewSubmenuItem(tableViewMenuItem: $0, action: selectedAction) }
    }

    func execute() -> YoshiActionResult {
        let debugViewController = DebugViewController(options: options, isRootYoshiMenu: false, completion: nil)
        return .push(debugViewController)
    }

}
