//
//  YoshiMenuCellDataSource.swift
//  Yoshi
//
//  Created by Kanglei Fang on 24/02/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Cell data source defining the layout for YoshiMenu's cell
internal struct YoshiMenuCellDataSource: YoshiResuableCellDataSource {

    private let title: String

    private let subtitle: String?

    /// Initalize the YoshiMenuCellDataSource instance
    ///
    /// - Parameters:
    ///   - title: Main title for the cell
    ///   - subtitle: Subtitle for the cell
    init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }

    func cellFor(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YoshiMenuCellDataSource.reuseIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: YoshiMenuCellDataSource.reuseIdentifier)

        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle

        cell.accessoryType = .none

        return cell
    }
}
