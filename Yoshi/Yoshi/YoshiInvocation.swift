//
//  YoshiInvocation.swift
//  Pods
//
//  Created by Quentin Ribierre on 10/24/16.
//
//

import Foundation

/// Set of Yoshi invocation method.
public struct YoshiInvocation: OptionSet {

    /// An `OptionSet`'s `Element` type is normally `Self`.
    public let rawValue: UInt64

    /// Convert from a value of `RawValue`, succeeding unconditionally.
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }

    /// All invocations types.
    public static let all = YoshiInvocation(rawValue: 0)

    /// Shake motion gesture invocation type.
    public static let shakeMotionGesture = YoshiInvocation(rawValue: 1 << 0)

    /// Multi touch event invocation type.
    public static let multiTouch = YoshiInvocation(rawValue: 1 << 1)

    /// Force touch event invocation type.
    public static let forceTouch = YoshiInvocation(rawValue: 1 << 2)

}
