//
//  YoshiDateSelectorMenu.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 Protocol for defining a menu option for choosing a date.
 */
public protocol YoshiDateSelectorMenu: class, YoshiMenu {

    /// The selected date.
    var selectedDate: Date { get set }

    /// Function to handle the date selection.
    var didUpdateDate: (_ dateSelected: Date) -> Void { get }

}

public extension YoshiDateSelectorMenu {

    /**
     Function to execute when the menu item is seleted.

     - returns: A result for handling the selected menu item.
     */
    func execute() -> YoshiActionResult {
        let bundle = Bundle(for: YoshiConfigurationManager.self)
        let datePickerViewController =
            DebugDatePickerViewController(nibName: String(describing: DebugDatePickerViewController.self),
                                          bundle: bundle)
        datePickerViewController.modalPresentationStyle = .formSheet
        datePickerViewController.setup(self)

        return .presentViewController(datePickerViewController)
    }

}
