//
//  DebugTableViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/// The debug table view controller.
internal final class DebugTableViewController: UIViewController {

    fileprivate let yoshiTableViewCellDefaultIdentifier = "YoshiTableViewCellDefaultIdentifier"

    @IBOutlet private weak var tableView: UITableView!

    fileprivate var yoshiTableViewMenu: YoshiTableViewMenu?

    // MARK: - Public Functions

    func setup(_ yoshiTableViewMenu: YoshiTableViewMenu) {
        self.yoshiTableViewMenu = yoshiTableViewMenu
    }

    // MARK: - View Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = yoshiTableViewMenu?.title
    }
}

// MARK: - UITableViewDataSource

extension DebugTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yoshiTableViewMenu?.displayItems.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: yoshiTableViewCellDefaultIdentifier)
        cell.textLabel?.text = yoshiTableViewMenu?.displayItems[(indexPath as NSIndexPath).row].name
        cell.detailTextLabel?.text = yoshiTableViewMenu?.displayItems[(indexPath as NSIndexPath).row].subtitle
        cell.setupCopyToClipBoard()
        return cell
    }

}

// MARK: - UITableViewDelegate

extension DebugTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = yoshiTableViewMenu?.displayItems[(indexPath as NSIndexPath).row],
              !selectedItem.selected else {
            _ = navigationController?.popViewController(animated: true)
            return
        }

        // Deselect all items that can not be selected at the same time
        yoshiTableViewMenu?.displayItems.forEach { item in
            item.selected = false
        }

        // Select the newly selected item
        selectedItem.selected = true

        yoshiTableViewMenu?.didSelectDisplayItem(selectedItem)
        _ = navigationController?.popViewController(animated: true)
   }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        guard let selectedItem = yoshiTableViewMenu?.displayItems[(indexPath as NSIndexPath).row],
              selectedItem.selected else {
            return
        }

        cell.accessoryType = .checkmark
    }

}
