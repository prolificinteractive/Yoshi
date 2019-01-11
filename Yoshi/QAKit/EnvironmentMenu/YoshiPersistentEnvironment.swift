//
//  YoshiPersistentEnvironment.swift
//  Yoshi
//
//  Created by Kanglei Fang on 27/09/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// An class container used to help enum YoshiEnvironment encoding since enum encoding is not supported.
class YoshiPersistentEnvironment<T: YoshiEnvironment & Codable>: Codable {
    
    /// Persisted Environment.
    private(set) var persistedEnvironment: T
    
    /// Initialize the YoshiPersistentEnvironment with a given YoshiEnvironment.
    ///
    /// - Parameter environment: The YoshiEnvironment need to be archived.
    init(environment: T) {
        persistedEnvironment = environment
    }
}
