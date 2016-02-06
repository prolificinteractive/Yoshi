//
//  DebugDatePickerViewController.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/24/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

protocol DebugDatePickerViewControllerDelegate {
    /**
     Delegate method that informs a delegate when the date selection has changed

     - parameter date: (NSDate) the new date
     */
    func didUpdateDate(date: NSDate)

    /**
     Delegate method that informs a delegate when the date picker should be dismissed

     - parameter viewController: (UIViewController) the view controller to be dismissed
     */
    func shouldDismissDatePickerView(viewController: UIViewController)
}

internal class DebugDatePickerViewController: UIViewController {

    @IBOutlet private weak var datePicker: UIDatePicker!

    var datePickerViewControllerDelegate: DebugDatePickerViewControllerDelegate?
    var date = NSDate()
    var selectorMenu: YoshiDateSelectorMenu?

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
        navigationItem.title = selectorMenu?.debugMenuName
    }

    // MARK: IBAction Methods

    @IBAction func cancelBarButtonItemTouched(sender: UIBarButtonItem) {
        datePickerViewControllerDelegate?.shouldDismissDatePickerView(self)
    }

    @IBAction func applyBarButtonItemTouched(sender: UIBarButtonItem) {
        let date = datePicker.date
        datePickerViewControllerDelegate?.didUpdateDate(date)
        selectorMenu?.didUpdateDate(dateSelected:date)
        datePickerViewControllerDelegate?.shouldDismissDatePickerView(self)
    }

}
