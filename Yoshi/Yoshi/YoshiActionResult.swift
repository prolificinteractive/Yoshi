//
//  YoshiResult.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 The result types for a debug menu action.

- Handled:               Indicates that the action was handled and nothing else is required.
- PresentViewController: Indicates that a view is required to complete the action,
    returning the view controller to present.
- AsyncAfterDismissing:  Indicates that the action should be handled asynchronously after the view is dismissed.
*/
public enum YoshiActionResult {
    case handled
    case presentViewController(UIViewController)
    case asyncAfterDismissing(() -> Void)
}
