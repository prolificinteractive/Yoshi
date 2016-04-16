//
//  DebugDatePickerViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/24/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal class DebugDatePickerViewController: UIViewController {

    var date = NSDate()
    var selectorMenu: YoshiDateSelectorMenu?

    @IBOutlet private weak var datePicker: UIDatePicker!

    // MARK: Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }

    // MARK: Public Methods

    /**
    Sets up the DebugDatePickerViewController

    - parameter yoshiDateSelectorMenu: (YoshiDateSelectorMenu) the selector menu data
    */
    func setup(yoshiDateSelectorMenu: YoshiDateSelectorMenu) {
        selectorMenu = yoshiDateSelectorMenu
    }

    // MARK: Private Methods

    private func setupDatePicker() {
        datePicker.date = date
        navigationItem.title = selectorMenu?.title

        let closeButton = UIBarButtonItem(title: "Apply", style: .Plain, target: self, action: "apply:")
        navigationItem.rightBarButtonItem = closeButton
    }

    // MARK: IBAction Methods

    @objc private func apply(sender: UIBarButtonItem) {
        let date = datePicker.date
        selectorMenu?.didUpdateDate(dateSelected:date)
        navigationController?.popViewControllerAnimated(true)
    }

}
