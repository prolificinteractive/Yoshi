//
//  YoshiEncodableEnvironment.swift
//  Yoshi
//
//  Created by Kanglei Fang on 25/09/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Encodable and Codable HTTP environment.
internal struct YoshiEncodableEnvironment: Environment, Codable {
 
    public private(set) var name: String
    
    public private(set) var baseURL: URL
    
    /// Initialize a YoshiEncodableEnvironment from a generic Environment.
    ///
    /// - Parameter environment: Generic YoshiEnvironment
    init(environment: Environment) {
        self.name = environment.name
        self.baseURL = environment.baseURL
    }
}
