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
    
    typealias TableViewCellType = UITableViewCell

    /// The display name for the menu option.
    var title: String { get }

    /// The value for the option. This will be displayed as the subtitle in the menu.
    var subtitle: String? { get }
}

extension YoshiMenu {
    
    var cellReuseIdentifier: String {
        return "DebugViewControllerTableViewCellIdentifier"
    }
    
    func setupReusableCell(cell: UITableViewCell) {
        
    }
    
    func dequeueReusableCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
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
