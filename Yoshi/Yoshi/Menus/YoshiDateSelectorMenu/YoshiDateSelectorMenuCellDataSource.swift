//
//  YoshiDateSelectorMenuCellDataSource.swift
//  Yoshi
//
//  Created by Kanglei Fang on 24/02/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Cell data source defining the layout for YoshiDateSelectorMenu's cell
internal struct YoshiDateSelectorMenuCellDataSource: YoshiReusableCellDataSource {

    private let title: String

    private let date: Date
    
    private let dateFormatter: DateFormatter

    /// Intialize the YoshiDateSelectorMenuCellDataSource instance
    ///
    /// - Parameters:
    ///   - title: Main title for the cell
    ///   - date: Selected Date
    ///   - dateFormatter: DateFormatter for the date picker, default to medium dateStyle and short timeStyle
    init(title: String,
         date: Date,
         dateFormatter: DateFormatter) {
        self.title = title
        self.date = date
        self.dateFormatter = dateFormatter
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
