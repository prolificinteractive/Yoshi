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
public protocol YoshiDateSelectorMenu: YoshiMenu {

    /// Function to handle the date selection.
    var didUpdateDate: (dateSelected: NSDate) -> () { get }

}

public extension YoshiDateSelectorMenu {

    /**
     Function to execute when the menu item is seleted.

     - returns: A result for handling the selected menu item.
     */
    func execute() -> YoshiActionResult {
        let bundle = NSBundle(forClass: YoshiConfigurationManager.self)
        let datePickerViewController =
            DebugDatePickerViewController(nibName: String(DebugDatePickerViewController), bundle: bundle)
        datePickerViewController.modalPresentationStyle = .FormSheet
        datePickerViewController.setup(self)
        datePickerViewController.date = NSDate()

        return .PresentViewController(datePickerViewController)
    }

}
