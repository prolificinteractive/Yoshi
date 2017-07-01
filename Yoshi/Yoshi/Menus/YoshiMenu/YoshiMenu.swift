//
//  Yoshi.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/**
 Defines an object as a normal Yoshi style YoshiGenericMenu.
 */
public protocol YoshiMenu: YoshiGenericMenu {

    /// The display name for the menu option.
    var title: String { get }

    /// The value for the option. This will be displayed as the subtitle in the menu.
    var subtitle: String? { get }
}

public extension YoshiMenu {

    /// Default implementation for the cell data source, it will use the system cell with the given title and subtitle
    var cellSource: YoshiReusableCellDataSource {
        return YoshiMenuCellDataSource(title: title, subtitle: subtitle)
    }
}
