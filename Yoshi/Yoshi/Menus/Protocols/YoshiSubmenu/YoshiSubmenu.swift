//
//  YoshiSubmenu.swift
//  Pods
//
//  Created by Max Mamis on 6/27/17.
//
//

import Foundation

/// A submenu that contains an array of options.
/// Once selected, Yoshi will push the navigation stack to display these options.
public protocol YoshiSubmenu: YoshiMenu {

    /// Options for the submenu to display.
    var options: [YoshiGenericMenu] { get }

}

public extension YoshiSubmenu {

    func execute() -> YoshiActionResult {
        let debugViewController = DebugViewController(options: options, isRootYoshiMenu: false, completion: nil)
        debugViewController.title = self.title
        return .push(debugViewController)
    }

    var cellSource: YoshiReusableCellDataSource {
        return YoshiMenuCellDataSource(title: title, subtitle: subtitle, accessoryType: .disclosureIndicator)
    }

}
