//
//  CustomUIMenu.swift
//  YoshiExample
//
//  Created by Kanglei Fang on 7/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Yoshi

/// A menu with custom UI.
internal struct CustomUIMenu: YoshiGenericMenu {

    var cellSource: YoshiReusableCellDataSource {
        return CustomMenuCellDataSource()
    }

    func execute() -> YoshiActionResult {
        return .handled
    }
}

/// UI data source for CustomUIMenu that uses a custom xib file.
internal final class CustomMenuCellDataSource: YoshiReusableCellDataSource {

    static var nib: UINib? {
        return UINib(nibName: "CustomCell", bundle: nil)
    }

    func cellFor(tableView: UITableView) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CustomMenuCellDataSource.reuseIdentifier))
            as? CustomCell else {
                fatalError()
        }
        cell.label.text = "This is a custom cell"
        return cell
    }
}

/// A custom UITableViewCell.
internal final class CustomCell: UITableViewCell {

    /// Label outlet from storyboard
    @IBOutlet weak var label: UILabel!
}
