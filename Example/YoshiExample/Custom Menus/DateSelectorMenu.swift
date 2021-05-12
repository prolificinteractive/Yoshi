//
//  DateSelectorMenu.swift
//  YoshiExample
//
//  Created by Kanglei Fang on 7/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Yoshi

/// A date selector menu item to be displayed in Yoshi.
final class DateSelectorMenu: YoshiDateSelectorMenu {

    var title: String
    var subtitle: String?
    var selectedDate: Date
    var didUpdateDate: (_ dateSelected: Date) -> Void

    init(title: String,
         subtitle: String? = nil,
         selectedDate: Date = Date(),
         didUpdateDate: @escaping (Date) -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.selectedDate = selectedDate
        self.didUpdateDate = didUpdateDate
    }
}
