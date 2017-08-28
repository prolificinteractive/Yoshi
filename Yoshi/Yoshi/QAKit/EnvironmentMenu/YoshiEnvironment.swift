//
//  YoshiEnvironment.swift
//  Yoshi
//
//  Created by Kanglei Fang on 28/08/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

public protocol YoshiEnvironment: class {
    
    /// Environment name (e.g. "QA", "Production")
    var name: String { get }
    
    /// Environment base URL.
    var baseURL: URL { get }
}
