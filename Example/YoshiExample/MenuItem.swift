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

/**
 *  A menu item to be displayed in Yoshi.
 */
internal struct TableViewMenu: YoshiTableViewMenu {

    var title: String
    var subtitle: String?
    var displayItems: [YoshiTableViewMenuItem]
    var didSelectDisplayItem: (_ displayItem: YoshiTableViewMenuItem) -> Void

}

/**
 *  A date selector menu item to be displayed in Yoshi.
 */
internal final class DateSelector: YoshiDateSelectorMenu {

    var title: String
    var subtitle: String?
    var selectedDate: Date
    var didUpdateDate: (_ dateSelected: Date) -> Void

    init(title: String,
         subtitle: String? = nil,
         selectedDate: Date = Date(),
         didUpdateDate: @escaping (Date) -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.selectedDate = selectedDate
        self.didUpdateDate = didUpdateDate
    }
}

/**
 *  A custom menu item to be displayed in Yoshi.
 */
internal struct CustomMenu: YoshiMenu {

    let title: String
    let subtitle: String?
    let completion: (() -> Void)?

    func execute() -> YoshiActionResult {
        guard let completion = completion else {
            return .handled
        }

        return .asyncAfterDismissing(completion)
    }
    
}

/// A menu with custom UI
internal struct MenuWithCustomUI: YoshiGenericMenu {

    var cellSource: YoshiResuableCellDataSource {
        return CustomMenuCellDataSource()
    }

    func execute() -> YoshiActionResult {
        return .handled
    }
    
}

/// Datasource for MenuWithCustomUI to dequeue CustomCell
internal final class CustomMenuCellDataSource: YoshiResuableCellDataSource {

    static var nib: UINib? {
        return UINib(nibName: "CustomCell", bundle: nil)
    }

    func cellFor(tableView: UITableView) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CustomMenuCellDataSource.reuseIdentifier)) as? CustomCell else {
                fatalError()
        }
        cell.label.text = "This is a custom cell"
        return cell
    }
    
}

/// A custom UITableViewCell
internal final class CustomCell: UITableViewCell {

    /// Label outlet from storyboard
    @IBOutlet weak var label: UILabel!
    
}
