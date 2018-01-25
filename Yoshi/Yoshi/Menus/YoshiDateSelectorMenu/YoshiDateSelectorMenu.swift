//
//  YoshiDateSelectorMenu.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 A date menu used to display and select from date picker.
 */
open class YoshiDateSelectorMenu: YoshiMenu {
    
    public var title: String
    public var subtitle: String?
    
    /// Selected Date of the menu.
    public var selectedDate: Date
    
    /// The callback when date is selected.
    public var didUpdateDate: (_ dateSelected: Date) -> Void
    
    private let dateFormatter: DateFormatter
    
    open static var defaultDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }
    
    /// Intialize a YoshiDateSelectorMenu
    ///
    /// - Parameters:
    ///   - title: Main title for the cell.
    ///   - subtitle: Subtitle for the cell.
    ///   - selectedDate: Selected Date.
    ///   - dateFormatter: date formatter of the date picker. default to medium date style and short time style.
    ///   - didUpdateDate: Callback when the date is selected.
    public init(title: String,
         subtitle: String? = nil,
         selectedDate: Date = Date(),
         dateFormatter: DateFormatter = defaultDateFormatter,
         didUpdateDate: @escaping (Date) -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.selectedDate = selectedDate
        self.didUpdateDate = didUpdateDate
        self.dateFormatter = dateFormatter
    }
    
    public var cellSource: YoshiReusableCellDataSource {
        return YoshiDateSelectorMenuCellDataSource(title: title, date: selectedDate, dateFormatter: dateFormatter)
    }
    
    public func execute() -> YoshiActionResult {
        let bundle = Bundle(for: YoshiConfigurationManager.self)
        let datePickerViewController =
            DebugDatePickerViewController(nibName: String(describing: DebugDatePickerViewController.self),
                                          bundle: bundle)
        datePickerViewController.modalPresentationStyle = .formSheet
        datePickerViewController.setup(self)

        return .push(datePickerViewController)
    }
}
