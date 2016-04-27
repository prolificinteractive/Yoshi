//
//  DebugDatePickerViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/24/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/// The date picker view controller.
internal class DebugDatePickerViewController: UIViewController {

    private var selectorMenu: YoshiDateSelectorMenu?

    @IBOutlet private weak var datePicker: UIDatePicker!

    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
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
    func setup(yoshiDateSelectorMenu: YoshiDateSelectorMenu) {
        selectorMenu = yoshiDateSelectorMenu
    }

    // MARK: - Private Functions

    private func setupDatePicker() {
        datePicker.date = selectorMenu?.selectedDate ?? NSDate()
        navigationItem.title = selectorMenu?.title

        let closeButton = UIBarButtonItem(title: "Apply",
                                          style: .Plain,
                                          target: self,
                                          action: #selector(DebugDatePickerViewController.apply(_:)))
        navigationItem.rightBarButtonItem = closeButton
    }

    // MARK: - IBAction

    @objc private func apply(sender: UIBarButtonItem) {
        let date = datePicker.date
        selectorMenu?.selectedDate = date
        selectorMenu?.didUpdateDate(dateSelected:date)
        navigationController?.popViewControllerAnimated(true)
    }

}
