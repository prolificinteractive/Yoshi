//
//  DebugTableViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal final class DebugTableViewController: UIViewController {

    private let yoshiTableViewCellDefaultIdentifier = "YoshiTableViewCellDefaultIdentifier"
    @IBOutlet private weak var tableView: UITableView!
    private var yoshiTableViewMenu: YoshiTableViewMenu?

    // MARK: Public Methods

    func setup(yoshiTableViewMenu: YoshiTableViewMenu) {
        self.yoshiTableViewMenu = yoshiTableViewMenu
    }

    // MARK: ViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = yoshiTableViewMenu?.title
    }
}

// MARK: UITableViewDataSource

extension DebugTableViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yoshiTableViewMenu?.displayItems.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: yoshiTableViewCellDefaultIdentifier)
        cell.textLabel?.text = yoshiTableViewMenu?.displayItems[indexPath.row].name
        return cell
    }

}

// MARK: UITableViewDelegate

extension DebugTableViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectedItem = yoshiTableViewMenu?.displayItems[indexPath.row] where !selectedItem.selected else {
            navigationController?.popViewControllerAnimated(true)
            return
        }

        // Deselect all items that can not be selected at the same time
        yoshiTableViewMenu?.displayItems.forEach { item in
            item.selected = false
        }
        
        // Select the newly selected item
        selectedItem.selected = true
        
        yoshiTableViewMenu?.didSelectDisplayItem(displayItem: selectedItem)
        navigationController?.popViewControllerAnimated(true)
   }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectedItem = yoshiTableViewMenu?.displayItems[indexPath.row] where selectedItem.selected else {
            return
        }
        cell.accessoryType = .Checkmark
    }
}
