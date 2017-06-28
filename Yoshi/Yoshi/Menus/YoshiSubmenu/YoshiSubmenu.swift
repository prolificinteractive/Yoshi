//
//  YoshiSubmenu.swift
//  Pods
//
//  Created by Max Mamis on 6/27/17.
//
//

import Foundation

public protocol YoshiSubmenu: YoshiMenu {
    
    var options: [YoshiGenericMenu] { get }
    
}

public extension YoshiSubmenu {
    
    func execute() -> YoshiActionResult {
        let debugViewController = DebugViewController(options: options, isRootYoshiMenu: false, completion: nil)
        debugViewController.title = self.title
        return .push(debugViewController)
    }
    
    var cellSource: YoshiResuableCellDataSource {
        return YoshiMenuCellDataSource(title: title, subtitle: subtitle, accessoryType: .disclosureIndicator)
    }
    
}
