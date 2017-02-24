//
//  YoshiDataSelectorMenuCellDataSource.swift
//  Yoshi
//
//  Created by Kanglei Fang on 24/02/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

internal struct YoshiDataSelectorMenuCellDataSource: YoshiResuableCellDataSource {

    private let title: String

    private let date: Date

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }

    init(title: String, date: Date) {
        self.title = title
        self.date = date
    }

    func cellFor(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YoshiMenuCellDataSource.reuseIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: YoshiMenuCellDataSource.reuseIdentifier)

        cell.textLabel?.text = title
        cell.detailTextLabel?.text = dateFormatter.string(from: date)

        cell.accessoryType = .disclosureIndicator

        return cell
    }
}
