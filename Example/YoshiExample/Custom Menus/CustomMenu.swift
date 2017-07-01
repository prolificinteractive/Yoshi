//
//  CustomMenu.swift
//  YoshiExample
//
//  Created by Kanglei Fang on 7/1/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Yoshi

/// A custom menu item to be displayed in Yoshi.
internal struct CustomMenu: YoshiMenu {
    
    let title: String
    let subtitle: String?
    let completion: (() -> Void)?
    
    func execute() -> YoshiActionResult {
        guard let completion = completion else {
            return .handled
        }
        
        return .asyncAfterDismissing(completion)
    }
}
