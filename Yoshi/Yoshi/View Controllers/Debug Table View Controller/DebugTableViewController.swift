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

    var menu: YoshiTableViewMenu?
    var delegate: DebugTableViewControllerDelegate?

    // MARK: Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    func setup(yoshiTableViewMenu: YoshiTableViewMenu) {
        self.menu = yoshiTableViewMenu
    }

    // MARK: ViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.menu?.debugMenuName
    }

    // MARK: IBAction Methods

    @IBAction private func cancelBarButtonItemTouched(sender: UIBarButtonItem) {
        self.delegate?.shouldDismissDebugTableView(self)
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
        self.delegate?.shouldDismissDebugTableView(self)
    }
    
}

// MARK: UIViewController extension

extension UIViewController {

    /**
     The nib name for a view controller

     - returns: (String) the nib name for a view controller
     */
    class func nibName() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last ?? ""
    }

}
