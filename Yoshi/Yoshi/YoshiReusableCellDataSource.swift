//
//  YoshiReusableCellDataSource.swift
//  Yoshi
//
//  Created by Kanglei Fang on 24/02/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// Object helps YoshiGenericMenu define cell's UI when presented in Yoshi.
public protocol YoshiReusableCellDataSource {

    /// Reuse identifier for the cell
    static var reuseIdentifier: String { get }

    /// Nib file for the cell, nullable
    static var nib: UINib? { get }

    /// Function to dequeue the cell for the given Yoshi table view
    /// - Note: Cell class is registrated automatically when Yoshi tableview initialized
    ///
    /// - Parameters:
    ///   - tableView: Yoshi debug table view, note that this property is used mainly for calling `dequeueReusableCell`.
    ///   Modification on the tableview is disencouraged
    /// - Returns: An UITableViewCell instance
    func cellFor(tableView: UITableView) -> UITableViewCell
}

public extension YoshiReusableCellDataSource {

    /// Default reuseIdentifier implementation, it will use the protocol adopator's name
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    /// Default nib implementation, nil
    static var nib: UINib? {
        return nil
    }
}
