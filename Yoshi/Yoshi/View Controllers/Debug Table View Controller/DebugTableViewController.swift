//
//  DebugTableViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal class DebugTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var menu: YoshiTableViewMenu?
    let yoshiTableViewCellDefaultIdentifier = "YoshiTableViewCellDefaultIdentifier"

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func nibName() -> String {
        return NSStringFromClass(DebugTableViewController.self).componentsSeparatedByString(".").last ?? ""
    }

    func setup(yoshiTableViewMenu: YoshiTableViewMenu) {
        self.menu = yoshiTableViewMenu
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.menu?.debugMenuName
    }

    @IBAction private func cancelBarButtonItemTouched(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: UITableViewDataSource

extension DebugTableViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu?.displayItems.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: yoshiTableViewCellDefaultIdentifier)
        cell.textLabel?.text = self.menu?.displayItems[indexPath.row].displayText()

        return cell
    }

}

// MARK: UITableViewDelegate

extension DebugTableViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectedItem = self.menu?.displayItems[indexPath.row] else {
            return
        }

        self.menu?.didSelectDisplayItem(displayItem: selectedItem)
        DebugConfigurationManager.sharedInstance.inDebugMenu = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
