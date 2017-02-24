//
//  YoshiTableViewMenuCellDataSource.swift
//  Yoshi
//
//  Created by Kanglei Fang on 24/02/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

internal struct YoshiTableViewMenuCellDataSource: YoshiResuableCellDataSource {

    private let title: String

    private let subtitle: String?

    init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }

    func cellFor(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YoshiMenuCellDataSource.reuseIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: YoshiMenuCellDataSource.reuseIdentifier)

        cell.textLabel?.text = title

        if let subtitle = subtitle {
            cell.detailTextLabel?.text = subtitle
        } else {
            cell.detailTextLabel?.text = nil
        }

        cell.accessoryType = .disclosureIndicator

        return cell
    }
}
