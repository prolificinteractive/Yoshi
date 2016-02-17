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
- PresentViewController: Indicates that a view is required to complete the action.
- AsyncAfterDismissing:  Indicates that the action should be handled asynchronously after the view is dismissed.
*/
public enum YoshiResult: Equatable {

    case Handled
    case PresentViewController
    case AsyncAfterDismissing(() -> Void)

    func asyncBlock() -> () -> Void {
        switch self {
        case .AsyncAfterDismissing(let block):
            return block
        default:
            return { }
        }
    }
    
}

public func == (left: YoshiResult, right: YoshiResult) -> Bool {
    switch (left, right) {
    case (.Handled, .Handled):
        return true
    case (.PresentViewController, .PresentViewController):
        return true
    case (.AsyncAfterDismissing, .AsyncAfterDismissing):
        return true
    default:
        return false
    }
}