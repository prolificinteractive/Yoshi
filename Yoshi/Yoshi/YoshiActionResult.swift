//
//  YoshiActionResult.swift
//  Yoshi
//
//  Created by Christopher Jones on 2/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 A debug menu option result
 */
public struct YoshiActionResult {

    /// The result of the action.
    let result: YoshiResult
    /// A view controller; this will be nil in the event that the result is .Handled.
    let viewController: UIViewController?

    /**
     An empty result, indicating that the action was handled and no further work is necessary.
     */
    public init() {
        result = .Handled
        viewController = nil
    }

    public init(action: () -> Void) {
        result = .AsyncAfterDismissing(action)
        viewController = nil
    }

    /**
     A result indicating a view controller is required to handle the action.

     - parameter viewController: The view controller to present.
     */
    public init(forPresentingViewController viewController: UIViewController) {
        result = .PresentViewController
        self.viewController = viewController
    }

}
