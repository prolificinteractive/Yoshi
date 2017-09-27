//
//  YoshiActionMenu.swift
//  Yoshi
//
//  Created by Kanglei Fang on 06/07/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// A standard menu that execute custom actions when tapped.
open class YoshiActionMenu: YoshiMenu {

    public let title: String
    public let subtitle: String?
    private let completion: (() -> Void)?

    /// Initialize the menu with title, an optional subtitle and action executed when being tapped.
    ///
    /// - Parameters:
    ///   - title: Title of the menu.
    ///   - subtitle: Subtitle of the menu, default to nil.
    ///   - completion: Action executed when tapped.
    public init(title: String,
                subtitle: String? = nil,
                completion: (() -> Void)?) {
        self.title = title
        self.subtitle = subtitle
        self.completion = completion
    }

    open func execute() -> YoshiActionResult {
        return .asyncAfterDismissing(completion)
    }

}
