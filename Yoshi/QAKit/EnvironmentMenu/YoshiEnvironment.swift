//
//  YoshiEnvironment.swift
//  Yoshi
//
//  Created by Kanglei Fang on 25/09/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Default basic implementation of Environment protocol.
public struct YoshiEnvironment: Environment {
    
    public private(set) var name: String
    
    public private(set) var baseURL: URL
    
    /// Initialize the YoshiEnvironment with the given name and URL.
    ///
    /// - Parameters:
    ///   - name: Name of the environment.
    ///   - baseURL: Base URL of the environment.
    public init(name: String, baseURL: URL) {
        self.name = name
        self.baseURL = baseURL
    }
}
