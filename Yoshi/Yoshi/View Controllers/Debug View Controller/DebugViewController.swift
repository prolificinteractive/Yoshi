//
//  DebugViewController.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

internal typealias VoidCompletionBlock = Void -> Void

/// A debug menu.
internal final class DebugViewController: UIViewController {

    let completionHandler: (completed: VoidCompletionBlock? ) -> Void

    private let tableView = UITableView()
    private let options: [YoshiMenu]

    init(options: [YoshiMenu], completion: (VoidCompletionBlock?) -> Void) {
        self.options = options
        self.completionHandler = completion
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        setupNavigationController()
        setupTableView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .Top,
            relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: tableView, attribute: .Leading,
            relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: tableView,
            attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: .Bottom,
            relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0.0)

        view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = tableViewHeader()
    }

    private func tableViewHeader() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 160))
        let imageView = UIImageView(image: AppBundleUtility.icon())
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .CenterX,
            relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal,
            toItem: view, attribute: .Top, multiplier: 1.0, constant: 38.0)

        view.addConstraints([centerXConstraint, topConstraint])

        let versionLabel = UILabel()
        versionLabel.text = AppBundleUtility.appVersionText()
        versionLabel.textColor = Color(105, 105, 105).toUIColor()
        versionLabel.font = UIFont.systemFontOfSize(12)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(versionLabel)

        let labelCenterXConstraint = NSLayoutConstraint(item: versionLabel, attribute: .CenterX,
            relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let labelTopConstraint = NSLayoutConstraint(item: versionLabel, attribute: .Top, relatedBy: .Equal,
            toItem: imageView, attribute: .Bottom, multiplier: 1.0, constant: 8.0)
        view.addConstraints([labelCenterXConstraint, labelTopConstraint])

        let separatorLine = UIView()
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLine)

        separatorLine.backgroundColor = tableView.separatorColor
        let lineBottomConstraint = NSLayoutConstraint(item: separatorLine, attribute: .Bottom,
            relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let lineWidthConstraint = NSLayoutConstraint(item: separatorLine, attribute: .Width,
            relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        let lineHeightConstraint = NSLayoutConstraint(item: separatorLine, attribute: .Height,
            relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.5)
        view.addConstraints([lineBottomConstraint, lineWidthConstraint, lineHeightConstraint])

        return view
    }

    private func setupNavigationController() {
        let closeButton = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "close:")
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.title = AppBundleUtility.appDisplayName()
    }

    @objc private func close(sender: UIBarButtonItem) {
        completionHandler(completed: nil)
    }
}

extension DebugViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DebugViewControllerTableViewCellIdentifier"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) ??
            UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)

        let option = options[indexPath.row]
        cell.textLabel?.text = option.title
        cell.detailTextLabel?.text = option.subtitle

        switch option {
        case _ as YoshiDateSelectorMenu:
            cell.accessoryType = .DisclosureIndicator
        case _ as YoshiTableViewMenu:
            cell.accessoryType = .DisclosureIndicator
        default:
            cell.accessoryType = .None
        }

        return cell
    }

}

extension DebugViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let selectedOption = options[indexPath.row]
        switch selectedOption.execute() {
        case .PresentViewController(let viewController):
            navigationController?.pushViewController(viewController, animated: true)
            break
        case .AsyncAfterDismissing(let asyncAction):
            completionHandler(completed: asyncAction)
            break
        default:
            return
        }
    }

}
