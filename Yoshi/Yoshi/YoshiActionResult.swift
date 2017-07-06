//
//  YoshiResult.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

///  The result types for a debug menu action.
///
/// - handled: Indicates that the action was handled and nothing else is required.
/// - present: Indicates that a view is required to complete the action, returning the view controller to present.
/// - push: Indicates that a view is required to complete the action, returning the view controller to push.
/// - pop: Indicates that the action should pop the navigation stack.
///        Yoshi won't do anything if it's in the root of the stack.
/// - asyncAfterDismissing->Void: Indicates that the action should be handled asynchronously after the view is.
//  dismissed.
public enum YoshiActionResult {
    case handled
    case present(UIViewController)
    case push(UIViewController)
    case pop
    case asyncAfterDismissing((() -> Void)?)
}
