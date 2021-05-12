//
//  YoshiDateSelectorMenuCellDataSource.swift
//  Yoshi
//
//  Created by Kanglei Fang on 24/02/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Cell data source defining the layout for YoshiDateSelectorMenu's cell
struct YoshiDateSelectorMenuCellDataSource: YoshiReusableCellDataSource {

    private let title: String

    private let date: Date

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        return dateFormatter
    }

    /// Intialize the YoshiDateSelectorMenuCellDataSource instance
    ///
    /// - Parameters:
    ///   - title: Main title for the cell
    ///   - date: Selected Date
    init(title: String, date: Date) {
        self.title = title
        self.date = date
    }

    func cellFor(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YoshiDateSelectorMenuCellDataSource.reuseIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: YoshiDateSelectorMenuCellDataSource.reuseIdentifier)

        cell.textLabel?.text = title
        cell.detailTextLabel?.text = dateFormatter.string(from: date)

        cell.accessoryType = .disclosureIndicator

        return cell
    }
}
