//
//  DebugDatePickerViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/24/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/// The date picker view controller.
class DebugDatePickerViewController: UIViewController {

    private var selectorMenu: YoshiDateSelectorMenu?

    @IBOutlet private weak var datePicker: UIDatePicker!

    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }

    // MARK: - Public Functions

    /**
    Sets up the DebugDatePickerViewController

    - parameter yoshiDateSelectorMenu: (YoshiDateSelectorMenu) the selector menu data
    */
    func setup(_ yoshiDateSelectorMenu: YoshiDateSelectorMenu) {
        selectorMenu = yoshiDateSelectorMenu
    }

    // MARK: - Private Functions

    private func setupDatePicker() {
        datePicker.date = selectorMenu?.selectedDate as Date? ?? Date()
        navigationItem.title = selectorMenu?.title

        let closeButton = UIBarButtonItem(title: "Apply",
                                          style: .plain,
                                          target: self,
                                          action: #selector(DebugDatePickerViewController.apply(_:)))
        navigationItem.rightBarButtonItem = closeButton
    }

    // MARK: - IBAction

    @objc private func apply(_ sender: UIBarButtonItem) {
        let date = datePicker.date
        selectorMenu?.selectedDate = date
        selectorMenu?.didUpdateDate(date)
        _ = navigationController?.popViewController(animated: true)
    }

}
