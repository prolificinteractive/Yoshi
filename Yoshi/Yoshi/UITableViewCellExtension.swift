//
//  UITableViewCellExtension.swift
//  Yoshi
//
//  Created by Quentin Ribierre on 12/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

// MARK: - UITableView extension.
extension UITableViewCell {

    /// Setup a long press gesture on the cell to copy the subtitle (detailTextLabel's text) to the clipboard.
    func setupCopyToClipBoard() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCopyToClipBoard(_:)))
        addGestureRecognizer(longPressGesture)
    }

    /// Handle long press gesture to copy the cell's subtitle to the clipboard.
    ///
    /// - Parameter sender: Long
    func longPressCopyToClipBoard(_ sender: UIGestureRecognizer) {
        guard sender.state == .began, let subtitle = detailTextLabel?.text else {
            return
        }

        UIPasteboard.general.string = subtitle

        // Log for user feedback, will be replaced by some kind of alert later on.
        print("\(subtitle) copied!")
    }
    
}
