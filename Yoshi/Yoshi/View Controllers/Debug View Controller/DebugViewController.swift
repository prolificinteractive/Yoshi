//
//  DebugViewController.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

typealias VoidCompletionBlock = () -> Void

/// A debug menu.
final class DebugViewController: UIViewController {

    var completionHandler: ((_ completed: VoidCompletionBlock? ) -> Void)?

    /// Configures navigation bar and table view header for root Yoshi menu
    private let isRootYoshiMenu: Bool
    private let tableView = UITableView()
    private let options: [YoshiGenericMenu]

    private let dateFormatter: DateFormatter = DateFormatter()

    init(options: [YoshiGenericMenu], isRootYoshiMenu: Bool, completion: ((VoidCompletionBlock?) -> Void)?) {
        self.options = options
        self.completionHandler = completion
        self.isRootYoshiMenu = isRootYoshiMenu
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDateFormatter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top,
            relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: tableView, attribute: .leading,
            relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: tableView, attribute: .trailing,
            relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom,
            relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])

        tableView.dataSource = self
        tableView.delegate = self

        if isRootYoshiMenu {
            tableView.tableHeaderView = tableViewHeader()
        }

        registerCellClasses(options: options)
    }

    private func registerCellClasses(options: [YoshiGenericMenu]) {
        var registeredCells = Set<String>()

        // Register for each reuse Identifer for once
        options.forEach { option in
            let reuseIdentifier = type(of:option.cellSource).reuseIdentifier
            if let registeredNib = type(of:option.cellSource).nib, !registeredCells.contains(reuseIdentifier) {
                registeredCells.insert(reuseIdentifier)
                tableView.register(registeredNib, forCellReuseIdentifier: reuseIdentifier)
            }
        }
    }

    private func tableViewHeader() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 160))
        let imageView = UIImageView(image: AppBundleUtility.icon())
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX,
            relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal,
            toItem: view, attribute: .top, multiplier: 1.0, constant: 38.0)

        view.addConstraints([centerXConstraint, topConstraint])

        let versionLabel = UILabel()
        versionLabel.text = AppBundleUtility.appVersionText()
        versionLabel.textColor = Color(105, 105, 105).toUIColor()
        versionLabel.font = UIFont.systemFont(ofSize: 12)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(versionLabel)

        let labelCenterXConstraint = NSLayoutConstraint(item: versionLabel, attribute: .centerX,
            relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let labelTopConstraint = NSLayoutConstraint(item: versionLabel, attribute: .top, relatedBy: .equal,
            toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        view.addConstraints([labelCenterXConstraint, labelTopConstraint])

        let separatorLine = UIView()
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLine)

        separatorLine.backgroundColor = tableView.separatorColor
        let lineBottomConstraint = NSLayoutConstraint(item: separatorLine, attribute: .bottom,
            relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lineWidthConstraint = NSLayoutConstraint(item: separatorLine, attribute: .width,
            relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lineHeightConstraint = NSLayoutConstraint(item: separatorLine, attribute: .height,
            relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.5)
        view.addConstraints([lineBottomConstraint, lineWidthConstraint, lineHeightConstraint])

        return view
    }

    private func setupNavigationController() {
        guard isRootYoshiMenu else {

            /// Non-root Yoshi menus keep default back button
            return
        }

        let closeButton = UIBarButtonItem(title: "Close",
                                          style: .plain,
                                          target: self,
                                          action: #selector(DebugViewController.close(_:)))
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.title = AppBundleUtility.appDisplayName()
    }

    private func setupDateFormatter() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }

    @objc private func close(_ sender: UIBarButtonItem) {
        if let completionHandler = completionHandler {
            completionHandler(nil)
        }
    }

    private func passCompletionHandler(to viewController: UIViewController) {
        if let debugViewController = viewController as? DebugViewController,
            let completionHandler = completionHandler,
            debugViewController.completionHandler == nil {
            debugViewController.completionHandler = completionHandler
        }
    }
}

extension DebugViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options[(indexPath as NSIndexPath).row]
        let cell = option.cellSource.cellFor(tableView: tableView)
        cell.setupCopyToClipBoard()
        return cell
    }
}

extension DebugViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedOption = options[(indexPath as NSIndexPath).row]
        switch selectedOption.execute() {
        case .push(let viewController):
            passCompletionHandler(to: viewController)
            navigationController?.pushViewController(viewController, animated: true)
        case .present(let viewController):
            passCompletionHandler(to: viewController)
            navigationController?.present(viewController, animated: true)
        case .asyncAfterDismissing(let asyncAction):
            completionHandler?(asyncAction)
        case .pop:
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }

}
