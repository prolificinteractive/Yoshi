//
//  YoshiEnvironment.swift
//  Yoshi
//
//  Created by Kanglei Fang on 28/08/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

func == (left: YoshiEnvironment, right: YoshiEnvironment) -> Bool {
    return left.baseURL == right.baseURL
}

/// HTTP environment.
public protocol YoshiEnvironment {

    /// Environment name (e.g. "QA", "Production")
    var name: String { get }

    /// Environment base URL.
    var baseURL: URL { get }
}
