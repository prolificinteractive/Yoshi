//
//  DebugTableViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

protocol DebugTableViewControllerDelegate {
    func shouldDismissDebugTableView(viewController: UIViewController)
}

internal class DebugTableViewController: UIViewController {

    let yoshiTableViewCellDefaultIdentifier = "YoshiTableViewCellDefaultIdentifier"

    @IBOutlet private weak var tableView: UITableView!

    var yoshiTableViewMenu: YoshiTableViewMenu?
    var tableViewControllerDelegate: DebugTableViewControllerDelegate?

    // MARK: Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    func setup(yoshiTableViewMenu: YoshiTableViewMenu) {
        self.yoshiTableViewMenu = yoshiTableViewMenu
    }

    // MARK: ViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = yoshiTableViewMenu?.debugMenuName
    }

    // MARK: IBAction Methods

    @IBAction private func cancelBarButtonItemTouched(sender: UIBarButtonItem) {
        tableViewControllerDelegate?.shouldDismissDebugTableView(self)
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
        cell.textLabel?.text = yoshiTableViewMenu?.displayItems[indexPath.row].displayText()

        return cell
    }

}

// MARK: UITableViewDelegate

extension DebugTableViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectedItem = yoshiTableViewMenu?.displayItems[indexPath.row] else {
            return
        }

        yoshiTableViewMenu?.didSelectDisplayItem(displayItem: selectedItem)
        tableViewControllerDelegate?.shouldDismissDebugTableView(self)
    }

}
