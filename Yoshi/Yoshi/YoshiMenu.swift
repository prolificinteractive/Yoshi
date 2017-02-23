//
//  Yoshi.swift
//  Yoshi
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

/**
 Defines an object as a debug menu option
 */
public protocol YoshiMenu: YoshiGenericMenu {

    /// The display name for the menu option.
    var title: String { get }

    /// The value for the option. This will be displayed as the subtitle in the menu.
    var subtitle: String? { get }
}

extension YoshiMenu {
    
    func dequeueReusableCell() -> UITableViewCell {
        let cellIdentifier = "DebugViewControllerTableViewCellIdentifier"
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        cell.textLabel?.text = title
        
        if let subtitle = subtitle {
            cell.detailTextLabel?.text = subtitle
        } else {
            cell.detailTextLabel?.text = nil
        }
        
        cell.accessoryType = .none
        
        return cell
    }
}
